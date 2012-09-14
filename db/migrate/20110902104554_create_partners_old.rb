class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.string :name
      t.string :avatar
      t.text :biography
      t.text :description

      t.timestamps
    end
  end
end
