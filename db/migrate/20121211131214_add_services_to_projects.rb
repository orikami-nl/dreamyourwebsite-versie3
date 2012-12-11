class AddServicesToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :services, :string
  end
end
