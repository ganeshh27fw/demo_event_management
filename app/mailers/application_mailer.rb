class ApplicationMailer < ActionMailer::Base
  default from: 'communication@bme.com'

  layout "mailer"
end
