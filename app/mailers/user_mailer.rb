class UserMailer < ActionMailer::Base
  default from: "admin@bikes.bechnu.com"
  def test(user)  
    mail(:to => user.email, :subject => "Registered")  
  end

  def send_to_friend(name, to, bike)
  	@name = name
  	@bike= bike
  	mail(:to => to, :subject => "BikeSales") 
  end
  def enquiry(name, email, tel, comment, bike)	
  	@name = name
  	@tel= tel
  	@comment = comment
    @email = email
  	@bike= bike
  	enquiry= "Enquiry"
  	mail(:to => @bike.user.email, :subject => enquiry) 
  	
  end
  def contact(name, email, tel, comment)  
    @name = name
    @email= email

    @tel= tel
    @comment = comment
    enquiry= "User Contact Us Enquiry"
    mail(:to => "contactus@bikes.bechnu.com", :subject => enquiry) 
    
  end
end
