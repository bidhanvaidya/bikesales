ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.live.com",  
  :port                 => 25,  
  :domain               => "asciicasts.com",  
  :user_name            => "admin@bikes.bechnu.com",  
  :password             => "Dikshya19",  
  :authentication       => "plain",  
  :enable_starttls_auto => true  
}