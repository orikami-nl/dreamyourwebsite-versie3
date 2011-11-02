class MobileController < ApplicationController
  layout "mobile"

  before_filter :check_honeypots, :only => [:create]

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
    session[:mobile] = true    
    @partners = Partner.all
    @projects = Project.all
    @addresses = ["info@dreamyourweb.nl"]
    @contact_form = ContactForm.new
end

def create
    @contact_form = ContactForm.new(params[:contact_form])
    if @contact_form.deliver
	respond_to do |format|
	format.html { redirect_to root_url, :notice => "Uw bericht is verzonden, u krijgt zo snel mogelijk een 		reactie van ons."}
	format.js {render}
    end
    else
      render :action => :index
    end
end

end



