class WorkerSkill < ApplicationRecord
  validates :worker_id, :skill_id, presence: true

  belongs_to :worker
  belongs_to :skill
end
