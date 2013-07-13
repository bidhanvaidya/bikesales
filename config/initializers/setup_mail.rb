ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.live.com",  
  :port                 => 25,  
  :domain               => "asciicasts.com",  
  :user_name            => "no-reply@bikes.bechnu.com",  
  :password             => "Market19",  
  :authentication       => "plain",  
  :enable_starttls_auto => true  
}