class CreateRelatedSkillsJob
  include Sidekiq::Job

  def perform(request_id)
    job = JobRequest.find(request_id)
    skills = JSON.parse(job.skills_array)
    skills.each do |skill_id|
      JobRequiredSkill.create(job_request_id: job.id, skill_id: skill_id, killer: false)
    end
  end
end
