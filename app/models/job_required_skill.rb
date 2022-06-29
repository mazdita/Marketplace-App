class JobRequiredSkill < ApplicationRecord
  validates :job_request_id, :skill_id, presence: true
  validates :killer, inclusion: {in: [true, false]}

  belongs_to :skill
  belongs_to :job_request
end
