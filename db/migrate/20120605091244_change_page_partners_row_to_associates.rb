class ChangePagePartnersRowToAssociates < ActiveRecord::Migration
  def change
  	Page.where(:key => :partners).first.update_attribute :key, "associates"
  end
end
