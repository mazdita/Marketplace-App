class AddTotalVacanciesToJobRequest < ActiveRecord::Migration[6.1]
  def change
    add_column :job_requests, :total_vacancies, :integer
  end
end
