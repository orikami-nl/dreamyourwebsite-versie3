class ContactController < ApplicationController
	before_filter :check_honeypots, :only => [:create]
	before_filter :get_email_addresses, :only => [:index, :create] 
	layout "sidebar_layout", :except => "completed"
	manageable_content_for :body, :title, :side, :layout => "sidebar_layout" 

  #caches_action :index
  
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

	def get_email_addresses
		@partners = Partner.where(:active => true)
		@addresses = ["info@dreamyourweb.nl"]
		@partners.each do |partner|
			@addresses = @addresses << (partner.name.match(/\w+/).to_s.downcase + "@dreamyourweb.nl")
		end
	end

	def index
		@contact_form = ContactForm.new
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
		kiss_identify @contact_form.info
		kiss_record "Send contact mail", {"email" => @contact_form.to}
		messages = flash[:kiss_metrics]
		logger.info "INFO: " + messages.to_s	
		messages.each do |msg|
			logger.info "INFO: " + msg.to_s
		end




    unless messages.blank? || messages.empty?
      messages.each do |mhash|
        if mhash.first[0] == :record
          recordstr = ""
          mhash.each do |msg|
            if msg.first == :record
              recordstr = %Q{'#{msg.first.to_s}', '#{msg.last.to_s}'}
            end
            if msg.first == "props"
              opts = msg.last.to_s.gsub("=>", ":")
              logger.info %Q{_kmq.push([#{recordstr}, #{opts}]);} 
            end
          end
        end     
      end
    end





    else
      render :action => :index
    end
	end
end
