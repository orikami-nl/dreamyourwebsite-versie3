class AddExternalUrlToProject < ActiveRecord::Migration
  def up
		add_column :projects, :external_url, :string
  end

  def down
		remove_column :projects, :external_url
  end
end
