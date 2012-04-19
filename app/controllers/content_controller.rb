class ContentController < ApplicationController
	
	before_filter :authenticate_admin!

	def update

		content = JSON.parse(params["content"])
		regions = content.keys
		p "REGIONS: " + regions.to_s

		savesuccess = 0

		regions.each do |region|
			idarr = region.split(':')
			if idarr[0] == "page"
				page_id = idarr[1]
				page_content_id = idarr[2]
				contentvalue = content[region]["value"]

	  			@item = Page.find(page_id).page_contents.find(page_content_id)
				@item.content = contentvalue
				if @item.save
					savesuccess = 1
				end
			elsif idarr[0] == "post"
				post_id = idarr[1]
				part = idarr[2]

				p @post = Post.find(post_id)

				if part == "excerpt"
					@post.excerpt = content[region]["value"]
				elsif part == "body"
					@post.body = content[region]["value"]
				end				

				if @post.save
					savesuccess = savesuccess + 1
				end
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
