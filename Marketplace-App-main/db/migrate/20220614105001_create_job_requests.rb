class CreateJobRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :job_requests do |t|
      t.date :start_date
      t.date :end_date
      t.string :job_function
      t.string :address
      t.integer :vacancies_count
      t.integer :monthly_salary
      t.string :status
      t.text :details
      t.integer :client_id

      t.timestamps
    end
  end
end
