class Post < ActiveRecord::Base
	acts_as_taggable
	has_paper_trail

	belongs_to :associate
	has_many :comments, :dependent => :destroy
	attr_accessible :published_at, :excerpt, :body, :title, :title_for_url, :tag_list, :draft
	validates_presence_of :title
	validates_uniqueness_of :title_for_url
	before_save :build_url
	default_scope order("published_at DESC")

	def build_url
		self.title_for_url = self.title.to_url
	end

	def to_param
		self.title_for_url
	end

	def self.drafts(show=false)
    if false
      self.where(:draft => false)
    else
    	self
    end
  end

  rails_admin do 
    edit do
      field :excerpt, :text do
        codemirror true
        codemirror_config :mode => 'markdown',:theme => 'night', :lineWrapping => true
        codemirror_assets :mode => '/assets/codemirror/modes/markdown.js',  :theme => '/assets/codemirror/themes/night.css'
      end
      field :body, :text do
        codemirror true
        codemirror_config :mode => 'markdown',:theme => 'night', :lineWrapping => true
        codemirror_assets :mode => '/assets/codemirror/modes/markdown.js',  :theme => '/assets/codemirror/themes/night.css'
      end
    end
  end 

end
