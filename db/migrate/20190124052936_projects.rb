# frozen_string_literal: true

class Projects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |p|
      p.text :name
      p.date :start_date
      p.date :expected_target_date
    end
  end
end
