class ContentController < ApplicationController
	
	before_filter :authenticate_admin!

	def update

		content = JSON.parse(params["content"])
		regions = content.keys
		p "REGIONS: " + regions.to_s

		savesuccess = 0

		regions.each do |region|
			idarr = region.split(':')
			page_id = idarr[0]
			page_content_id = idarr[1]
			contentvalue = content[region]["value"]

  			@item = Page.find(page_id).page_contents.find(page_content_id)
			@item.content = contentvalue
			if @item.save
				savesuccess = 1
			end
		end

		respond_to do |format|
			if savesuccess
				format.html  { redirect_to('/home', :notice => 'Success.') }
	      		format.json  { render :json => {}, :status => :ok }
	      	else
				format.html  { redirect_to('/home', :notice => 'Save failed') }
	      		format.json  { render :json => {}, status: :unprocessable_entity }
	      	end
	    end
	end

end
