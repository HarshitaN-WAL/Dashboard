# frozen_string_literal: true

class AddRoleIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role_id, :integer
  end
end
