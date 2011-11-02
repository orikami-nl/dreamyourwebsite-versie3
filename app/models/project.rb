class Project < ActiveRecord::Base
	attr_accessible :title, :picture, :excerpt, :category, :title_for_url, :external_url
	validates_presence_of :title
	mount_uploader :picture, PictureUploader
	validates_uniqueness_of :title_for_url
	before_save :build_url

	def build_url
		self.title_for_url = self.title.to_url
	end

	def to_param
		self.title_for_url
	end
end
