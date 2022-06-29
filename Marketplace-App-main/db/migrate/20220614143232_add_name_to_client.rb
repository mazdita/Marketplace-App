class AddNameToClient < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :name, :string
    add_column :clients, :address, :string
  end
end
