class AdminController < ApplicationController

	def index
		@sites = Site.find(:all,:order => "created_at DESC")
	end

	def archive
		@site = Site.find params[:id]
		@site.active = false
		@site.save
		redirect_to "/admin"
	end
	
	def activate
		@site = Site.find params[:id]
		@site.active = true
		@site.save
		redirect_to "/admin"
	end

	def import
		Site.import
#		Site.find(:all).each do |site|
#			site.import_images
#		end
		redirect_to "/admin"
	end

	def import_site
		site = Site.find_by_name(params[:id])
		site.import_images
		redirect_to "/admin"
	end
	
	def session
		render :text => request.session_options[:hash]
	end

	def participants
		@participants = Participant.find :all
		render :json => @participants
	end

	def set_map
		@site = Site.find(params[:id])
		if params[:map_export]
			@site.map_export = params[:map_export]
			@site.save
			redirect_to "/admin"
		end
	end

end
