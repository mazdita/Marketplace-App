class UpdateWorkerSkillsJob
  include Sidekiq::Job

  def perform(id)
    @worker = Worker.find(id)
    WorkerSkill.where(worker_id: id).destroy_all
    skills = JSON.parse(@worker.skills_array)
    puts skills.class
    skills.each do |skill_id|
      WorkerSkill.create(worker_id: id, skill_id: skill_id)
    end
  end
end
