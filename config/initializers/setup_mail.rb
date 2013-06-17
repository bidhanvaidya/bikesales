ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.gmail.com",  
  :port                 => 587,  
  :domain               => "asciicasts.com",  
  :user_name            => "bidhanvaidya",  
  :password             => "Bv4222213",  
  :authentication       => "plain",  
  :enable_starttls_auto => true  
}