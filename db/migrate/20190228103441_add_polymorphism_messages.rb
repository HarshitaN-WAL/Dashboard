# frozen_string_literal: true

class AddPolymorphismMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :messageable_id, :integer
    add_column :messages, :messageable_type, :string
  end
end
