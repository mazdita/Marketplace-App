require "will_paginate/array"
class JobRequestsController < ApplicationController
    before_action :authorize_client, only: [:new, :create, :update, :edit, :destroy] 
    before_action :is_owner_client, only: [:update, :edit, :destroy]

    def index
        if current_admin
            @q = JobRequest.ransack(params[:q])
            @job_requests = @q.result(distinct: true).paginate(page: params[:page]).order('market_value DESC')
        else
            if current_worker
                @q = JobRequest.ransack(params[:q])
                @job_requests = @q.result(distinct: true)
                @job_requests.each do |job|
                    job.calculate_user_fit_score(current_worker)
                end
                @job_requests = @job_requests.select {|job| job.user_fit_score >= 1}.sort_by {|job| -job.user_fit_score}
                @job_requests = @job_requests.paginate(page: params[:page], per_page: 20)
            else
                @q = JobRequest.ransack(params[:q])
                @job_requests = @q.result(distinct: true).paginate(page: params[:page])
            end
        end
    end

    def show
        @request = JobRequest.find(params[:id])
        @candidacy = Candidacy.new
    end

    def new
        @request = JobRequest.new
        @client = current_client
        @skills = Skill.all
    end

    def create
        @request = JobRequest.new(job_request_params)
        @client = current_client
        @request[:total_vacancies] = @request[:vacancies_count]
        @request[:market_value] = @request[:monthly_salary] * @request[:total_vacancies]
        # @skills = job_request_params[:skill_array]
        if @request.save
            CreateRelatedSkillsJob.perform_async(@request.id)
            redirect_to update_skills_path(@request.id)
        else
            redirect_to new_job_request_path
            puts @request.errors.full_messages
        end
    end

    def edit
        @request = JobRequest.find(params[:id])
        @client = @request.client
        @skills = Skill.all.to_a
        # byebug
    end

    def update
        @request = JobRequest.find(params[:id])
        @client = @request.client.id
        @request[:total_vacancies] = @request[:vacancies_count]#put in model, before_save?
        @request[:market_value] = @request[:monthly_salary] * @request[:total_vacancies]#put in model
        
        if @request.update(job_request_params)
            flash[:success] = "Request Updated"
            UpdateRelatedSkillsJob.perform_async(@request.id, job_request_params.to_h)
            redirect_to job_request_path(@request)
        else
            redirect_to edit_job_request_path(@request)
            puts @request.errors.full_messages
        end
    end

    def destroy
        JobRequest.find(params[:id]).destroy
        redirect_to job_requests_path
    end

    def workers
        @job = JobRequest.find(params[:job_request_id])
        @killer_skills = @job.job_required_skills.select {|skill| skill.killer == true}
        @killer_skills_ids = []
        @killer_skills.each {|skill| @killer_skills_ids << skill.skill}
        puts @killer_skills_ids
        @workers = Worker.all
        @workers.each do |worker|
            worker.calculate_job_fit_score(@job)
        end
        @workers = @workers.select {|worker| (@killer_skills_ids & worker.skills).count >= 1}
        @workers = @workers.sort_by {|worker| -worker.job_fit_score}
        @workers = @workers.paginate(page: params[:page], per_page: 50)
    end

    private
    
    def job_request_params 
        params.require(:job_request).permit(:client_id, :job_function, :address, :start_date, :end_date, :vacancies_count, :monthly_salary, :details, skills_array:[])
    end

    def authorize_client
        redirect_back(fallback_location: root_path) unless current_client
    end

    def is_owner_client
        @request = JobRequest.find(params[:id])
        redirect_back(fallback_location: root_path) unless current_client.id == @request.client.id
    end
end
