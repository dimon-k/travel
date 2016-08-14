class SettingsController < ApplicationController

	before_action :authenticate_user!
	before_action :user_or_admin

	def index
		@users = User.order('lastname ASC').all
	end

	def destroy
		@user = User.find(params[:id])
		@user.soft_delete
	    redirect_to settings_path
	end

	# Change users role ADMIN to NOT_ADMIN and vice verse
  	def change_user_authority
  		@user = User.find(params[:id])
  		if @user.admin == true
  			@user.admin = false
  		else
  			@user.admin = true
  		end
  		@user.save
  		redirect_to settings_path
  	end

end