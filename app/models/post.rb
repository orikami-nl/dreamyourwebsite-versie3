class Post < ActiveRecord::Base
	acts_as_taggable

	belongs_to :partner
	has_many :comments, :dependent => :destroy
	attr_accessible :published_at, :excerpt, :body, :title, :title_for_url, :tag_list, :draft
	validates_presence_of :title
	validates_uniqueness_of :title_for_url
	before_save :build_url
	default_scope order("created_at DESC")

	def build_url
		self.title_for_url = self.title.to_url
	end

	
	def to_param
		self.title_for_url
	end
end
