class AddExcerptToProject < ActiveRecord::Migration
  def up
		add_column :projects, :excerpt, :text
  end

  def down
		remove_column :projects, :excerpt
  end
end
