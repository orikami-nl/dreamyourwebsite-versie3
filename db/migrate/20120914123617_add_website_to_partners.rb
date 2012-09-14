class AddWebsiteToPartners < ActiveRecord::Migration
  def change
      add_column :partners, :website, :string
  end
end
