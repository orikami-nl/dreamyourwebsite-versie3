module ApplicationHelper
	def menu_item(text, controller)
		if request.path_parameters[:controller] == controller
			'{ ' + text + ' }'
		elsif request.path.include?(controller) && controller == "blog"
			'{ ' + text + ' }'
		else
			text
		end
	end

	def sub_menu_item(text, action)
		if request.path_parameters[:action] == action
			'{ ' + text + ' }'
		else
			text
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
end
