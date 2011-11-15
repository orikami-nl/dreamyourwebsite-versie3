module ApplicationHelper
	#Obsolete for Andres design
	def sub_menu_item(text, action)
		if action_active?(action)
			'>> ' + text
		else
			text
		end

	end
	
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

	def path_to_category(project)
		if project.category == "Webdevelopment"
			"products/webdevelopment"
		elsif project.category == "Concept development"
			"products/concept_development"
		else
			"products/mobile"
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
end
