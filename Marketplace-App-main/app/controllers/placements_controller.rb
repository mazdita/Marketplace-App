class PlacementsController < ApplicationController
    before_action :authorize_admin
    before_action :placement_already_exists, only: [:new, :create]
    before_action :worker_already_placed, only: [:new, :create]

    def index
        @placements = Placement.paginate(page: params[:page])
    end

    def show
        @placement = Placement.find(params[:id])
    end

    def new
        @params = params[:placement]
        @preview = {candidacy_id: @params[:candidacy_id],
                    worker_id: @params[:worker_id],
                    client_id: @params[:client_id],
                    monthly_salary: @params[:monthly_salary],
                    start_date: @params[:start_date],
                    end_date: @params[:end_date]}

        @placement = Placement.new(@preview)
    end

    def create
        @placement = Placement.new(placement_params)
        puts params
        @candidacy = @placement.candidacy
        @request = @placement.job_request
        @worker = @placement.worker
        if @placement.save
            AfterPlacementCreateJob.perform_async(@candidacy.id, @request.id, @worker.id)
            redirect_to placement_path(@placement)
            send_email_to_client(@request.client)
            #send email to worker
        else
          puts @placement.errors.full_messages
          
            flash[:warning] = @placement.errors.full_messages
            redirect_back(fallback_location: root_path)
        end
    end

    def edit
        @placement = Placement.find(params[:id])
    end

    def update
        @placement = Placement.find(params[:id])
        if @placement.update(placement_params)
            redirect_to placement_path(@placement)
        else
            redirect_to edit_placement_path(@placement)
        end
    end

    def destroy
        Placement.find(params[:id]).destroy
        redirect_to placements_path
    end

    # def get_active_placements_current_month
        
    #     return 'Api-Key no encontrada' if params[:api_key]
    #     api_key = params[:api_key]
    #     return if !authenticate(api_key)
    #     current_date = Time.now
    #     @placements = Placement.joins(:client).joins(:worker).joins(:candidacy).where("placements.start_date <= ? AND placements.end_date >= ?", current_date, current_date)
    #     result = @placements.map{ |p| {client_name: p.client.name, worker_name: p.worker.first_name, job_function: p.candidacy.job_request.job_function,start_date: p.start_date, end_date: p.end_date ,monthly_salary: p.monthly_salary }}


    #     respond_to do |format|
    #         format.json {
    #           render json: result.to_json
    #         }
    #     end
    # end

    private
    def placement_params
        params.require(:placement).permit(:client_id, :worker_id, :candidacy_id, :start_date, :end_date, :monthly_salary)
    end

    def send_email_to_client(client)
        if  @request.vacancies_count == 0
            ClientMailer.notify_job_request_full(@client).deliver_now
        elsif @request.vacancies_count <= @request.total_vacancies * 0.75
            ClientMailer.notify_job_request_almost_full(@client).deliver_now
        end
    end

    def placement_already_exists
        worker_id = params[:placement][:worker_id]
        client_id = params[:placement][:client_id]
        candidacy_id = params[:placement][:candidacy_id]
        if Placement.exists?(worker_id: worker_id, client_id: client_id, candidacy_id: candidacy_id)
            redirect_back(fallback_location: root_path)  
        end
    end

    def worker_already_placed
        worker_id = params[:placement][:worker_id]
        if Placement.find(worker_id)
            redirect_back(fallback_location: root_path)
        end
    end
end
