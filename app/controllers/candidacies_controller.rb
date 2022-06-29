class CandidaciesController < ApplicationController
    before_action :only_workers, only: [:create]
    before_action :authorize_admin, only: [:index, :show, :update, :destroy]

    def index
        @candidacies = Candidacy.where(status: 0).paginate(page: params[:page])
    end

    def show
        @candidacy = Candidacy.find(params[:id])
        @placement = Placement.new
    end

    def new

    end

    def create
        @candidacy = Candidacy.new(candidacy_params)
        if @candidacy.save
            redirect_to worker_path(current_worker)
        else
            redirect_to root_path
            puts @candidacy.errors.full_messages
        end
    end

    def edit

    end

    def update
        @candidacy = Candidacy.find(params[:id])
        if @candidacy.update
            redirect_to candidacy_path(@candidacy)
        else
            redirect_to candidacy_path(@candidacy)
        end
    end

    def destroy
        Candidacy.find(params[:id]).destroy
    end

    private
    def candidacy_params
        params.require(:candidacy).permit(:worker_id, :job_request_id, :status, :start_date)
    end

    def only_workers
        redirect_back(fallback_location: root_path) unless current_worker || current_admin
    end
end
