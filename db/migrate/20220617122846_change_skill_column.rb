class ChangeSkillColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :clients, :skills
    add_column :job_requests, :skills, :text
  end
end
