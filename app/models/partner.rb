class Partner < ActiveRecord::Base
	has_many :posts
	attr_accessible :name, :avatar, :biography, :description, :name_for_url
	validates_presence_of :name
	mount_uploader :avatar, PictureUploader
	before_save :build_url
	
	def build_url
		self.name_for_url = self.name.to_url
	end

	def to_param
		self.name_for_url
	end
end
