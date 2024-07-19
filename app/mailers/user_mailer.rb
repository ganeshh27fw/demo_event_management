class   UserMailer < ApplicationMailer
  default from: 'communication@bme.com'

  def login_email(user)
    @user = user
    mail(to: @user.email, subject: 'Login Notification')
  end

  def logout_email(user)
    @user = user
    mail(to: @user.email, subject: 'Logout Notification')
  end

   def ticket_confirmation_email(user, booking, pdf)
    @user = user
    @booking = booking
    attachments['booking_confirmation.pdf'] = pdf
   
    mail(to: @user.email, subject: 'Ticket Confirmation')
  end
end
