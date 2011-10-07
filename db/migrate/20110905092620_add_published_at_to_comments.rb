class AddPublishedAtToComments < ActiveRecord::Migration
  def up
		add_column :comments, :published_at, :datetime
  end

  def down
		remove_column :comments, :published_at
  end
end
