class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :kiss

  def kiss
  	if admin_signed_in?
  		kiss_identify current_admin.email
  	end
	end

  private

	def after_sign_in_path_for(resource_or_scope)
	  kiss_identify resource_or_scope.email unless resource_or_scope.email.nil?
	  kiss_record "Signed In"
	  scope = Devise::Mapping.find_scope!(resource_or_scope)
	  home_path = "#{scope}_root_path"
	  respond_to?(home_path, true) ? send(home_path) : root_path
	end

	# Record a sign out
	def after_sign_out_path_for(resource_or_scope)
	  kiss_record "Signed Out"
	  home_path
	end

end
