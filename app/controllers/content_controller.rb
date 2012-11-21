class ContentController < ApplicationController
	
	before_filter :authenticate_admin!

	def update

		mercurycontent = params["content"]
		regions = mercurycontent.keys
		p "REGIONS: " + regions.to_s

		savesuccess = 0

		p "REGOIONS COUNT: " + regions.count.to_s

		regions.each do |region|
			idarr = region.split(':')

			model = idarr[0]
			model_id = idarr[1]
			model_field = idarr[2]
			content = mercurycontent[region]["value"]
			model[0] = model[0].capitalize
			if model == "Page"
				@item = model.constantize.find(model_id).page_contents.find(model_field)
				@item.update_attribute("content", content)
			else
				@item = model.constantize.find(model_id)
				@item.update_attribute(model_field, content)
			end

			if @item.save
				savesuccess = savesuccess + 1
			end
				
		end

		respond_to do |format|
			if savesuccess == regions.count
				format.html  { redirect_to('/home', :notice => 'Success.') }
	      		format.json  { render :json => {}, :status => :ok }
	      	else
				format.html  { redirect_to('/home', :notice => 'Save failed') }
	      		format.json  { render :json => {}, status: :unprocessable_entity }
	      	end
	    end
	end

end
