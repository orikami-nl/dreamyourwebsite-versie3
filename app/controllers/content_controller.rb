class ContentController < ApplicationController
	
	before_filter :authenticate_admin!

	def update

		mercurycontent = JSON.parse(params["content"])
		regions = mercurycontent.keys
		p "REGIONS: " + regions.to_s

		savesuccess = 0

		regions.each do |region|
			idarr = region.split(':')

			model = idarr[0]
			model_id = idarr[1]
			model_field = idarr[2]
			content = mercurycontent[region]["value"]
			model[0] = model[0].capitalize
			@item = model.constantize.find(model_id).page_contents.find(model_field)
			@item.update_attribute("content", content)

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
