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
  	render :partial => ab_test(experiment, *alternatives), :locals => {:currentexperiment => experiment} 
  end

end
