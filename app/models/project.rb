class Project < ActiveRecord::Base
	attr_accessible :title, :picture, :excerpt, :title_for_url, :external_url, :body, :full_picture, :project_type
	validates_presence_of :title
	mount_uploader :picture, ProjectThumbUploader
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

	def self.get_random(n=1)
		return self.find(:all).sample(n)
	end
end
