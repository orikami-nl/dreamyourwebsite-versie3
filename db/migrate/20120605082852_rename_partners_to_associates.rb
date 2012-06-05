class RenamePartnersToAssociates < ActiveRecord::Migration
    def self.up
        rename_table :partners, :associates
    end 
    def self.down
        rename_table :associates, :partners
    end
end
