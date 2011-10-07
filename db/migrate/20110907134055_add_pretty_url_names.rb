class AddPrettyUrlNames < ActiveRecord::Migration
  def up
		add_column :projects, :title_for_url, :string
		add_column :partners, :name_for_url, :string
		add_column :posts, :title_for_url, :string
  end

  def down
		remove_column :projects, :title_for_url
		remove_column :partners, :name_for_url
		remove_column :posts, :title_for_url
  end
end
