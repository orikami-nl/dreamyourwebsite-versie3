module ApplicationHelper
	def action_active?(action)
		if request.path_parameters[:action] == action
			true
		else
			false
		end
	end

	def controller_active?(controller)
		if request.path_parameters[:controller] == controller
			true
		elsif request.path.include?(controller) && controller == "blog"
			true
		else
			false
		end
	end

  def build_mail_address(partner_name)
		partner_name.match(/\w+/).to_s.downcase + "@dreamyourweb.nl"
	end

  def partner_mobile_path(partner_name)
		"#" + first_name(partner_name)
	end

  def first_name(partner_name)
		partner_name.match(/\w+/).to_s.downcase 
	end

  def project_short(project_title)
	project_title.match(/\w+/).to_s.downcase
  end

  def abkiss(experiment, *alternatives)
  	@currentexperiment = experiment
  	render :partial => ab_test(experiment, *alternatives), :locals => {:currentexperiment => experiment} 
  end

  def content_for(key)
 	page =  Page.find_by_key(controller.controller_name)
 	p "KEY: " + key.to_s
 	if page != nil
		pagecontents = page.page_contents.find_by_key(key)  
		if pagecontents == nil
			p "NEW PAGECONTENT"
			pagecontents = page.page_contents.new(:content => "")
			pagecontents.key = key
			pagecontents.save
			page.save
		end
  		pagecontent = pagecontents.content.html_safe
  		contenttag = content_tag(:div,pagecontent,:class => "mercury-region", "data-type" => "editable", :id =>page.id.to_s + ":" + pagecontents.id.to_s)
  	else
  		return "UNDEFINED!"
  	end

  	if pagecontent == nil
  		return "UNDEFINED!"
  	else
  		return contenttag
  	end
  end

end
