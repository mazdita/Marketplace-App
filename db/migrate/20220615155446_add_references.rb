class AddReferences < ActiveRecord::Migration[6.1]
  def change
    add_column :candidacies, :worker_id, :integer
    add_column :job_requests, :worker_id, :integer
  end
end
