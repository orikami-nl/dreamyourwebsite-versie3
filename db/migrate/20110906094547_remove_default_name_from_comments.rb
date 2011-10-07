class RemoveDefaultNameFromComments < ActiveRecord::Migration
  def up
     change_column :comments, :name, :string
  end

  def down
     change_column :comments, :name, :string, :default => "Anonymous", :null => false
  end
end
