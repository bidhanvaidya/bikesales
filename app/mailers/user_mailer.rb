class UserMailer < ActionMailer::Base
  default from: "no-reply@bikes.bechnu.com"
  def test(user)  
    mail(:to => user.email, :subject => "Registered")  
  end

  def send_to_friend(sender, name, to, bike, comment)
  	@sender = sender
    @name = name
    @comment= comment
  	@bike= bike
    attachments.inline['logo.jpg'] = File.read("app/assets/images/logo.jpg")
  	mail(:to => to, :subject => "BikeSales") 
  end
  def enquiry(name, email, tel, comment, bike)	
  	@name = name
  	@tel= tel
  	@comment = comment
    @email = email
  	@bike= bike
  	enquiry= "Enquiry"
    attachments.inline['logo.jpg'] = File.read("app/assets/images/logo.jpg")
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
  def send_to_spec(bike)
  @bike= bike
  mail(:to => "admin@bikes.bechnu.com", :subject => "Add Bike Spec") 
  end
end
