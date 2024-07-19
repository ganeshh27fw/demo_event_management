ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.sendmail_settings = {  :address => 'smtp.gmail.com',
    :port =>  587,
    :domain =>  'gmail.com',
    :authentication => 'plain',
    :enable_starttls_auto => true,
    :user_name => 'kandasamylearn@gmail.com',
    :password => 'lbtbonqmgpxobnfl'
}