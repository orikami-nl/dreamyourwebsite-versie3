class RenamePartnerColumnToAssociateColumn < ActiveRecord::Migration
  def change
    rename_column :posts, :partner_id, :associate_id
  end
end
