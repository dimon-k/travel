class SettingsController < ApplicationController

	before_action :authenticate_user!
	before_action :user_or_admin

	def index
		@users = User.all
	end

	def destroy
		@user = User.find(params[:id])
		@user.soft_delete
	    redirect_to settings_path
	end
end