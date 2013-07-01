class HowItWorksController < ApplicationController
	def index
		set_meta_tags :title => 'How it works At Bikes.bechnu.com',
              :description => "Search contact and buy or post, share and sell",
              :keywords => 'How it works',
              :canonical => "bikes.bechnu.com/how_it_works"
	end
end