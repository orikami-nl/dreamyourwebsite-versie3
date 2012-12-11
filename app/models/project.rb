class Project < ActiveRecord::Base
	attr_accessible :title, :picture, :excerpt, :title_for_url, :external_url, :body, :full_picture, :project_type, :vp, :services, :tech
	validates_presence_of :title
	mount_uploader :picture, ProjectThumbUploader
	mount_uploader :full_picture, FullPictureUploader
	validates_uniqueness_of :title_for_url
	before_save :build_url

	serialize :services, Array
	serialize :tech, Array

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

 	def services_enum
	  ["Consultancy", "Ontwikkeling", "Validatie", "Optimalisatie"]
  end

  def tech_enum
	  [["Ruby on Rails", "0"],
	   ["HTML5", "1"],
	   ["CSS3", "2"],
	   ["iOS", "3"],
	   ["jQuery", "4"],
	   ["MailChimp", "5"],
	   ["Mercury", "6"],
	   ["SVG", "7"],
	   ["Heroku", "8"],
	   ["AWS", ""],
	   ["Rails on Fire", "9"],
	   ["node.js", "10"],
	   ["d3.js", "11"],
	   ["raphael.js", "12"],
	   ["Android", "13"]]
  end

  def available_tech
  	[["Ruby on Rails", "http://rubyonrails.org/"],
	   ["HTML5", "http://www.w3.org/TR/html5/"],
	   ["CSS3", "http://www.w3.org/TR/CSS/"],
	   ["iOS", "http://www.apple.com/nl/ios/"],
	   ["jQuery", "http://jquery.com/"],
	   ["MailChimp", "http://mailchimp.com"],
	   ["Mercury", "http://jejacks0n.github.com/mercury/"],
	   ["SVG", "http://www.w3.org/Graphics/SVG/"],
	   ["Heroku", "http://www.heroku.com/"],
	   ["AWS", "http://aws.amazon.com/"],
	   ["Rails on Fire", "http://www.railsonfire.com/"],
	   ["node.js", "http://nodejs.org/"],
	   ["d3.js", "http://d3js.org/"],
	   ["raphael.js", "http://raphaeljs.com/"],
	   ["Android", "http://www.android.com/"]]
  end


end
