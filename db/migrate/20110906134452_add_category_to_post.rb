class AddCategoryToPost < ActiveRecord::Migration
  def up
		add_column :posts, :category, :string
  end

  def down
		remove_column :posts, :category
  end
end
