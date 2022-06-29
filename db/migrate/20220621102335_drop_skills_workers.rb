class DropSkillsWorkers < ActiveRecord::Migration[6.1]
  def change
    drop_table :skills_workers
  end
end
