module BikesHelper
	def facebook
		User.each do |current_user|
			if current_user.provider == 'facebook'
				begin
		          @user = FbGraph::User.me(current_user.facebook_token).fetch
		          if @user.permissions.include?(:publish_actions)
		            
		            picture= 'https://s3.amazonaws.com/bikesbechnu_public/logo.png'
		        
		            link= 'http://bikes.bechnu.com/?source=UPS'
		            @user.feed!(
		            :message => "Find all kinds of new and used bikes here. Post your bike here to sell your bike quickly",
		            :picture => picture,
		            :link => link,
		            :name => 'BikeSales',
		            :description =>  "Buy and sell new and used vehicles easily. For more bikes visit Bikes.bechnu.com" )
		          end
		        rescue
		        	puts "Expired token"

		    	else
		    		puts "successful"
		    	end	
	        end
    	end
	end
end
