class AddTechToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :tech, :string
  end
end
