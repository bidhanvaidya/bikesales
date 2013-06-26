class ContactsController < ApplicationController
	def index
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