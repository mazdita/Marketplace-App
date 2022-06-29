class AddSkillId < ActiveRecord::Migration[6.1]
  def change
    add_column :job_required_skills, :skill_id, :integer
  end
end
