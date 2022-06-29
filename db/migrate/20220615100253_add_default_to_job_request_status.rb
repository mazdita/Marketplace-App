class AddDefaultToJobRequestStatus < ActiveRecord::Migration[6.1]
  def change
    change_column :job_requests, :status, :string, default: "opened"
  end
end
