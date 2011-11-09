class AddPictureAndBodyToProject < ActiveRecord::Migration
  def up
		add_column :projects, :full_picture, :string
		add_column :projects, :body, :text
  end

  def down
		remove_column :projects, :full_picture
		add_column :projects, :body
  end
end
