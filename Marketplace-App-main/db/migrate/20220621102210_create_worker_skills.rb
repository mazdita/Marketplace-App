class CreateWorkerSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :worker_skills do |t|
      t.integer :worker_id
      t.integer :skill_id

      t.timestamps
    end
  end
end
