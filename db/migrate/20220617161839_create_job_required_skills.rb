class CreateJobRequiredSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :job_required_skills do |t|
      t.integer :skill_id
      t.integer :job_request_id
      t.boolean :killer

      t.timestamps
    end
  end
end
