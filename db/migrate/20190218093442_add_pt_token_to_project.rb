class AddPtTokenToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :pt_token, :string
  end
end
