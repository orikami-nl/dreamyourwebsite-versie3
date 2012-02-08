Then /^KISSmetrics receives the following properties:$/ do |table|
  table.hashes.each do |hash|
    property            = hash['property']
    value               = hash['value']
	expected_javascript = %Q{_kmq.push(['set', { '#{property}': '#{value}' }]);}
    page.should have_content(expected_javascript)
  end
end