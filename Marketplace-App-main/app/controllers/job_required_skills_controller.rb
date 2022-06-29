class JobRequiredSkillsController < ApplicationController
  def edit
    @job = JobRequest.find(params[:id])
    puts @job.skills
  end
  
  def update
    @job = JobRequest.find(params[:id]) 
    @skills = params[:killer]
    if @skills
        @skills.each do |skill_id| 
          @skill = JobRequiredSkill.where(job_request_id: @job.id, skill_id: skill_id)
          @skill.update_all(killer: true)
        end
    end
    redirect_to job_request_path(@job)
  end
end
