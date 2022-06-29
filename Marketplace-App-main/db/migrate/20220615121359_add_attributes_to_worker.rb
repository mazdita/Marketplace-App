class AddAttributesToWorker < ActiveRecord::Migration[6.1]
  def change
    add_column :workers, :first_name, :string
    add_column :workers, :last_name, :string
    #add_column :workers, :phone_number, :string
    add_column :workers, :country, :string
    add_column :workers, :city, :string
    #add_column :workers, :working, :boolean
    #add_column :workers, :rehirable, :boolean
  end
end
