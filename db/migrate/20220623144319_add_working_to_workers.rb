class AddWorkingToWorkers < ActiveRecord::Migration[6.1]
  def change
    add_column :workers, :working, :boolean, default: false
  end
end
