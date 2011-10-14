module ApplicationHelper
	def menu_item(text, controller)
		if controller_active?(controller)
			'>> ' + text
		else
			text
		end
	end

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
			"projects/webdevelopment"
		elsif project.category == "Concept development"
			"projects/concept_development"
		else
			"projects/mobile"
		end
	end

  def build_mail_address(partner_name)
		partner_name.match(/\w+/).to_s.downcase + "@dreamyourweb.nl"
	end
end
