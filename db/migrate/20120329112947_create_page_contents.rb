class CreatePageContents < ActiveRecord::Migration
  def change
    create_table :page_contents do |t|
      t.references :page
      t.string :key
      t.boolean :short, :default => false
      t.text :content

      t.timestamps
    end

    add_index :page_contents, [:page_id, :key], :unique => true
  end
end
