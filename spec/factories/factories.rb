Factory.define :post do |u|
  u.partner_id {Factory(:partner).id}
end

Factory.define :partner do |u|
	u.name "Karel Draaisma"
end
