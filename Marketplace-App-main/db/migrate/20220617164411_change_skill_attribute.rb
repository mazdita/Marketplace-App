class ChangeSkillAttribute < ActiveRecord::Migration[6.1]
  def change
    remove_column :job_required_skills, :skill_id
  end
end
