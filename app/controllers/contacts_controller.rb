class ContactsController < ApplicationController
	def index
		set_meta_tags :title => 'Contact Us, Bikes.bechnu.com',
              :description => "For more info about  bikes.bechnu.com, other projects, and advertising details",
              :keywords => 'Contact Us, Advertising, bikes.bechnu.com, bikes, secondhand, bechnu',
              :canonical => contacts_url
	end
	def post_email
		name = params[:name]
		email= params[:email]
		tel = params[:tel]
		comment= params[:comment]
		UserMailer.contact(name, email, tel, comment).deliver  
		respond_to do |format|
		  format.js
		 
		end

	end
end