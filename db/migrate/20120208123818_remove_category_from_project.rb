class RemoveCategoryFromProject < ActiveRecord::Migration
  def up
		remove_column :projects, :category		
  end

  def down
		add_column :projects, :category, :string		
  end
end
