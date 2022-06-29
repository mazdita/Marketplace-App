class CreateCandidacies < ActiveRecord::Migration[6.1]
  def change
    create_table :candidacies do |t|
      t.integer :status
      t.date :start_date
      t.integer :user_id
      t.integer :job_request_id

      t.timestamps
    end
  end
end
