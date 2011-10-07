class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :partner_id
      t.datetime :published_at
      t.text :excerpt
      t.text :body

      t.timestamps
    end
  end
end
