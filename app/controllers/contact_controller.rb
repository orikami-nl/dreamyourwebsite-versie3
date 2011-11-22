class ContactController < ApplicationController
	before_filter :check_honeypots, :only => [:create]
	layout "sidebar_layout", :except => "completed"
	manageable_content_for :body, :title, :side, :layout => "sidebar_layout" 

  caches_page :index
  
  def check_honeypots
    return true if honeypot_untouched?
    flash[:notice] = 'U bent een spambot, of gebruikt een vreemd script. (Zo niet, dan heb ik overdreven gereageerd. Probeer het alstublieft nog eens.)'
    redirect_to :back
    return false
  end

  def honeypot_untouched?
    submitted = params['its_so_sweet']
    return false if submitted.blank?
    submitted['email'] == 'john@doe.com' && submitted['name'] == '' && submitted['agree'].blank?
	end

	def index
		@contact_form = ContactForm.new
		@partners = Partner.all
		@addresses = ["info@dreamyourweb.nl"]
		@partners.each do |partner|
			@addresses = @addresses << (partner.name.match(/\w+/).to_s.downcase + "@dreamyourweb.nl")
		end
	end

	def completed
		render :layout => 'application' 
	end

	def create
    @contact_form = ContactForm.new(params[:contact_form])
		if @contact_form.deliver
      respond_to do |format|
        format.html { redirect_to contact_completed_path}
        format.js {render}
			end
    else
      render :action => :index
    end
	end
end
