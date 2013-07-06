class AboutUsController < ApplicationController
	def index
		set_meta_tags :title => 'About US, Our team, our Goal',
              :description => " Find new bike for sale &amp; 
     made by  Bidhan Vaidya, Romal Shrestha",
              :keywords => 'About Us, Bidhan Vaidya, Romal Shrestha',
              :canonical => about_us_url
	end
end