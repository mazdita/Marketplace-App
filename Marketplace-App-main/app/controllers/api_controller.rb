require "csv"

class ApiController < ApplicationController
  
  def data
    if authenticate
        @client = params[:client]
        @worker = params[:worker]
        @function = params[:function]
        @beginning_of_month = Time.now.beginning_of_month
        @end_of_month = Time.now.end_of_month
        puts @beginning_of_month,  @end_of_month
        @data = Placement.joins(:client, :worker, :job_request).where("clients.name LIKE ? and workers.first_name LIKE ? and job_requests.job_function LIKE ? and placements.start_date >= ? and placements.end_date >= ?", "%#{@client}%", "%#{@worker}%", "%#{@function}%", "%#{@beginning_of_month}%", "%#{@end_of_month}%")
        render :data
        puts @data.count
    else
        response = "no"
    end
  end

  def companies
    if authenticate
      @companies = Client.all
    else
    end
  end

  def update_token
    if current_admin
      current_admin.create_token
      redirect_back(fallback_location: root_path)
    else
      redirect_to root_path
    end
  end
  

  def token
    @admin = current_admin
  end

  private

  def authenticate
    api_key = params["token"]
    api_key_search = Admin.where(api_key: api_key).first if api_key
    if api_key_search.nil?
      return false
    else
      return true
    end
  end

    
  # def get_active_placements_current_month
        
  #   return 'Api-Key no encontrada' if params[:api_key]
  #   api_key = params[:api_key]
  #   return if !authenticate(api_key)
  #   current_date = Time.now
  #   @placements = Placement.joins(:client).joins(:worker).joins(:candidacy).where("placements.start_date <= ? AND placements.end_date >= ?", current_date, current_date)
  #   result = @placements.map{ |p| {client_name: p.client.name, worker_name: p.worker.first_name, job_function: p.candidacy.job_request.job_function,start_date: p.start_date, end_date: p.end_date ,monthly_salary: p.monthly_salary }}


  #   respond_to do |format|
  #       format.json {
  #         render json: result.to_json
  #       }
  #   end
  # end

  # def data
  #   #if authenticate
  #       current_date = Time.now
  #       #@data = Placement.joins(:client).joins(:worker).joins(:candidacy).where("placements.start_date <= ? AND placements.end_date >= ?", current_date, current_date)
  #       @data = Placement.all
  #       render :data
  #   #else
  #       #render
  #   #end
  # end
end
