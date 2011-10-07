class AddDefaultNameToComments < ActiveRecord::Migration
  def change
     change_column :comments, :name, :string, :default => "Anonymous", :null => false
  end
end
