class RegistrationsController < Devise::RegistrationsController

	before_action :authenticate_user!
	#before_action :user_or_admin, only: [:destroy] - as it has appeared, 
													#the line I added is not needed in that case

	def destroy
	    resource.soft_delete
	    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
	    set_flash_message :notice, :destroyed if is_navigational_format?
	    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  	end
end