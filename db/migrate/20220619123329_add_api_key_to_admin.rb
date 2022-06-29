class AddApiKeyToAdmin < ActiveRecord::Migration[6.1]
  def change
    add_column :admins, :api_key, :string
  end
end
