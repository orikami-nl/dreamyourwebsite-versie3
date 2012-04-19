class CreatePages < ActiveRecord::Migration
	def change
	    create_table :pages do |t|
	      t.string :key
	      t.string :locale

	      t.timestamps
	    end

	    add_index :pages, [:key, :locale], :unique => true
  	end
end
