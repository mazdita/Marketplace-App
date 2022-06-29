class ChangeSkillArrayType < ActiveRecord::Migration[6.1]
  def change
    remove_column :workers, :skills_array
    add_column :workers, :skills_array, :string
  end
end
