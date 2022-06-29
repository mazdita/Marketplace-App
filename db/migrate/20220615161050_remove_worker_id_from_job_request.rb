class RemoveWorkerIdFromJobRequest < ActiveRecord::Migration[6.1]
  def change
    remove_column :job_requests, :worker_id
    remove_column :placements, :user_id
    add_column :placements, :worker_id, :integer
  end
end
