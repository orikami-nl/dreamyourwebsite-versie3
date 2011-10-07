class Comment < ActiveRecord::Base
	belongs_to :post
	attr_accessible :published_at, :name, :email, :body
	validates_presence_of :body
  before_save :default_values

  def default_values
		if self.name == ""
    	self.name = 'Anonymous'
		end
  end

end
