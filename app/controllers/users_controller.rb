class UsersController < ApplicationController
 before_filter :authenticate_user!
 before_filter :user_profile
def profile
	@user=  current_user
	
	if params[:saved_bikes]=="true"
	saved_bikes= Array.new
	@favourites=current_user.favourites
	@favourites.each do |bike|
		if !Bike.unscoped.find(bike.bike_id).expired?
			saved_bikes = saved_bikes << Bike.find(bike.bike_id)
		end
	end
	@bikees = saved_bikes
	@listings = @user.bikes.desc(:created).limit(3)
	else
		@bikees= @user.bikes.desc(:created).paginate(:page => params[:page], :per_page => 4)
	@favourites=current_user.favourites.limit(3)
	end

end
end

def user_profile
	if current_user != User.find(params[:id])
	redirect_to profile_user_path(current_user.id)
	end	
end