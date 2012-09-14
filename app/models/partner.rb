class Partner < ActiveRecord::Base
  mount_uploader :logo, FullPictureUploader

  def self.get_random(n)
    return self.find(:all).sample(n)
  end

end
