class Skill < ApplicationRecord
    validates :name, presence: true

    has_many :job_required_skills
    has_many :workers
end
