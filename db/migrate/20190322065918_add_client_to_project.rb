class AddClientToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :client, :string
  end
end
