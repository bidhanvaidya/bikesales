class UsersController < ApplicationController
 before_filter :authenticate_user!
 before_filter :user_profile
def profile
	@user=  current_user
	@bikees= @user.bikes.paginate(:page => params[:page], :per_page => 4)
	

end
def user_profile
	if current_user != User.find(params[:id])
	redirect_to profile_user_path(current_user.id)
	end	
end
end