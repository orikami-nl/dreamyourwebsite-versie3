Factory.define :post do |u|
	u.sequence(:title) { |n| "Post#{n}th" }
	u.draft false
	u.excerpt "Samenvatting"
	u.body "Wat een verhaal"
  #u.association = :partner
end

Factory.define :partner do |u|
	u.active true
	u.biography "bio"
	u.description "describe"
end
