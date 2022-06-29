class UpdateRelatedSkillsJob
  include Sidekiq::Job

  def perform(id, params)
    JobRequiredSkill.where(job_request_id: id).destroy_all
    @skills = params["skills_array"]
    @skills.each do |skill_id| 
      JobRequiredSkill.create(job_request_id: id, skill_id: skill_id, killer: false)
    end
  end
end
