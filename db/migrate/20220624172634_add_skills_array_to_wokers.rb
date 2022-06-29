class AddSkillsArrayToWokers < ActiveRecord::Migration[6.1]
  def change
    add_column :workers, :skills_array, :integer
  end
end
