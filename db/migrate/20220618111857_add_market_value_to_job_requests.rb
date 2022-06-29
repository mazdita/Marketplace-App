class AddMarketValueToJobRequests < ActiveRecord::Migration[6.1]
  def change
    add_column :job_requests, :market_value, :integer
  end
end
