class UserMailerJob < ApplicationJob
  queue_as :mailers

  def perform(user, action)
    case action
    when 'login'
      UserMailer.login_email(user).deliver_later
    when 'logout'
      UserMailer.logout_email(user).deliver_later
    end
  end
end
