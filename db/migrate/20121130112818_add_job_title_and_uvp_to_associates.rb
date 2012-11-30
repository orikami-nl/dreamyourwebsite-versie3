class AddJobTitleAndUvpToAssociates < ActiveRecord::Migration
  def change
    add_column :associates, :job_title, :string
    add_column :associates, :uvp, :string
  end
end
