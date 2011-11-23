class Project < ActiveRecord::Base
	attr_accessible :title, :picture, :excerpt, :category, :title_for_url, :external_url, :body, :full_picture
	validates_presence_of :title, :external_url
	mount_uploader :picture, PictureUploader
	mount_uploader :full_picture, FullPictureUploader
	validates_uniqueness_of :title_for_url
	before_save :build_url

	def build_url
		self.title_for_url = self.title.to_url
	end

	def to_param
		self.title_for_url
	end

	def previous_project
	  self.class.last(:conditions => ["id < ?", id])
	end

	def next_project
	  self.class.first(:conditions => ["id > ?", id])
	end
end
