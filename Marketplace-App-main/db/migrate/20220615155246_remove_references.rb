class RemoveReferences < ActiveRecord::Migration[6.1]
  def change
    remove_column :candidacies, :user_id
    remove_column :job_requests, :user_id
  end
end
