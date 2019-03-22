class Repos < ActiveRecord::Migration[5.2]
  def change
    create_table :repos do |r|
      r.string :link
      r.integer :project_id
    end
  end
end
