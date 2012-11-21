class PageContent < ActiveRecord::Base
	belongs_to :page, :touch => true

  attr_accessible :content

  validates :page_id, :presence => true
  validates :key,     :presence => true

  default_scope order("#{ActiveRecord::Base.connection.quote_column_name('short')} DESC, #{ActiveRecord::Base.connection.quote_column_name('key')} ASC")


  rails_admin do 
    object_label_method do
      :rails_admin_label
    end
  end 

  def rails_admin_label
    ActiveSupport::Inflector.humanize(self.key)
  end

end
