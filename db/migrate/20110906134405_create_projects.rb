class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.string :picture
      t.text :description
      t.string :category

      t.timestamps
    end
  end
end
