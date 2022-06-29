class WorkersController < ApplicationController
  before_action :authorized_worker, only: [:edit, :update]
  before_action :allowed_to_see, only: :show

  def index
    @q = Worker.ransack(params[:q])
    @workers = @q.result(distinct: true).paginate(page: params[:page], per_page: 50).order('id ASC')
  end

  def show 
    @worker = Worker.find(params[:id])
  end

  def edit
    @skills = Skill.all
    @worker = Worker.find(params[:id])
    puts params
  end

  def update
    @worker = Worker.find(params[:id])
    if @worker.update(workers_params)
      flash[:success] = "Profile Updated"
      UpdateWorkerSkillsJob.perform_async(@worker.id)
      redirect_to worker_path(@worker)
    else
      redirect_to edit_worker_path(@worker)
      puts @worker.errors.full_messages
    end
  end

  def availability
    current_worker.change_availiability
    redirect_back(fallback_location: root_path)
  end
  
  private

  def workers_params
    params.require(:worker).permit(:first_name, :last_name , :email, :country, :city, :password, skills_array:[])
  end

  def authorized_worker
    redirect_back(fallback_location: root_path) unless current_worker.id == params[:id].to_i || current_admin
  end

  def allowed_to_see
    unless current_worker && current_worker.id == params[:id].to_i || current_admin || current_client && current_client.employees.any? {|worker| worker.id == params[:id].to_i}
      redirect_back(fallback_location: root_path)
    end
  end
end
