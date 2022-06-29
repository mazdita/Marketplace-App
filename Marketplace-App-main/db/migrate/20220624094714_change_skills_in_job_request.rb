class ChangeSkillsInJobRequest < ActiveRecord::Migration[6.1]
  def change
    remove_column :job_requests, :skills
    add_column :job_requests, :skills_array, :string
  end
end
