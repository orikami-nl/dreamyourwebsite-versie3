class RemovePublishedAtFromComments < ActiveRecord::Migration
  def down
		add_column :comments, :published_at, :datetime
  end

  def up
		remove_column :comments, :published_at
  end
end
