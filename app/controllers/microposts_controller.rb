class MicropostsController < ApplicationController
	before_filter :signed_in_user, :only => [:create, :destroy]
	before_filter :correct_user, :only => :destroy

	def create
		@micropost = current_user.microposts.build(params[:micropost])
		if @micropost.save
			flash[:success] = "Micropost created!"
			redirect_to root_path
		else
			if signed_in?
				@feed_items = current_user.feed.paginate(:page => params[:page])
			else
				@feed_items = []
			end
			render 'staticpages/home'
		end
	end

	def destroy
		@micropost.destroy
		flash[:success] = "the post deleted."
		redirect_back_or root_path
	end

	def index
	end

	private

	def correct_user
		@micropost = current_user.microposts.find_by_id(params[:id])
		redirect_to root_path if @micropost.nil?
	end
end