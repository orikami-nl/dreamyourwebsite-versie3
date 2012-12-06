class AddVpToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :vp, :text
  end
end
