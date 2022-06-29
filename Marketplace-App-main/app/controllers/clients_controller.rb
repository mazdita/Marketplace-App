class ClientsController < ApplicationController
    before_action :authorized_client, only: [:show]
    
    def index
        @clients = Client.paginate(page: params[:page])
        @clients_all = Client.all
        respond_to do |format|
            format.html
            format.json{
                render json: @clients_all.to_json
            }
            format.csv {send_data @clients_all}
        end
    end

    def show
        @client = Client.find(params[:id])
    end

    def edit
        @client = Client.find(params[:id])
    end

    def update
        @client = Client.find(params[:id])
        if @client.update(client_params)
            flash[:success] = "Profile Updated"
            redirect_to client_path(@client)
        else
            flash[:warning] = "Unable to edit"
            redirect_to edit_client_path(@client)
            puts @client.errors.full_messages
        end
    end

    def employees
        @employees = Client.find(params[:client_id]).employees
    end

    def send_offer_to_worker#maybe in the client model
        if current_client
            @worker = Worker.find(params[:worker_id])
            ClientMailer.send_offer_to_worker(client: current_client, worker: @worker).deliver_now#bgw??
            redirect_back(fallback_location: root_path)
        # else
        #     @client = Client.find(1)
        #     @worker = Worker.find(params[:worker_id])
        #     ClientMailer.send_offer_to_worker(client: @client, worker: @worker).deliver_now
        #     redirect_to workers_path
        end
    end

    private 

    def client_params
        params.require(:client).permit(:name, :email, :address)
    end
    
    def authorized_client
        redirect_back(fallback_location: root_path) unless current_client && current_client.id == params[:id].to_i || current_admin
    end
end
