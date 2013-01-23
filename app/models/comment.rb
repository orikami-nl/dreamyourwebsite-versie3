class Comment < ActiveRecord::Base
  acts_as_easy_captcha
	belongs_to :post
	attr_accessible :published_at, :name, :email, :body, :captcha
  validate :valid_captcha?,:on => :create
	validates_presence_of :body

  def name
    if self[:name] == "Anonymous"
      return ""
    else
      return self[:name]
    end
  end

  def clear_name
    self.name = nil
  end

  def put_captcha
    p "CAPTCHA"
    p self.captcha
    p @captcha_verification
  end

end
