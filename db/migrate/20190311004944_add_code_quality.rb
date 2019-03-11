class AddCodeQuality < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :github_slug, :string
    add_column :projects, :quality_token, :string
  end
end
