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

  def path_active?(path)
    if request.path == path
      return true
    else
      return false
    end
  end

  def build_mail_address(associate_name)
		associate_name.match(/\w+/).to_s.downcase + "@dreamyourweb.nl"
	end

  def associate_mobile_path(associate_name)
		"#" + first_name(associate_name)
	end

  def first_name(associate_name)
		associate_name.match(/\w+/).to_s.downcase 
	end

  def project_short(project_title)
	project_title.match(/\w+/).to_s.downcase
  end

  def abkiss(experiment, *alternatives)
  	@currentexperiment = experiment
  	render :partial => ab_test(experiment, *alternatives), :locals => {:currentexperiment => experiment} 
  end

  def mercury_content_for(key)
 	page =  Page.find_by_key(controller.controller_name)
 	p "CONTROLLER: " + controller.controller_name.to_s
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
  		contenttag = content_tag(:div,pagecontent,:class => "mercury-region", "data-type" => "editable", :id =>"page:"+page.id.to_s + ":" + pagecontents.id.to_s)
  	else
  		return "UNDEFINED!"
  	end

  	if pagecontent == nil
  		return "UNDEFINED!"
  	else
  		return contenttag
  	end
  end

  def blogpost_for(post)
 	if post != nil
		contenttag = content_tag(:div,post.excerpt.html_safe,:class => "mercury-region bold", "data-type" => "editable", :id => "post:" + post.id.to_s + ":excerpt") +
					 content_tag(:div,post.body.html_safe,:class => "mercury-region", "data-type" => "editable", :id => "post:" + post.id.to_s + ":body")
  	else
  		return "UNDEFINED!"
  	end

  	# if pagecontent == nil
  	# 	return "UNDEFINED!"
  	# else
  	# 	return contenttag
  	# end
  end

end
