class AddActiveToPartner < ActiveRecord::Migration
  def change
    add_column :partners, :active, :boolean, :default => true
  end
end
