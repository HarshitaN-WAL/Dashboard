class AddProjectReference < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :project_token , :string
  end
end
