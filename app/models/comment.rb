class Comment < ActiveRecord::Base
	belongs_to :post
	attr_accessible :published_at, :name, :email, :body, :captcha
	validates_presence_of :body
  before_save :default_values

  def default_values
		if self.name == ""
    	self.name = 'Anonymous'
		end
  end

  acts_as_easy_captcha
  validate :valid_captcha?,:on => :save
  
  def save
    super
    p "CAPTHCA"
    p @captcha
  end

end
