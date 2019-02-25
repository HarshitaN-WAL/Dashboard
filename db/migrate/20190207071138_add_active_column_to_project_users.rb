class AddActiveColumnToProjectUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :project_users, :active, :integer 
  end
end
