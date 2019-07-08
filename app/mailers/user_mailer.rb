class UserMailer < ApplicationMailer
  default :from => "application_name@domain.com"

  def registration_confirmation(user)
    @user = user
    mail(to: user.email, subject: "#{user.first_name} says you've changed.")
  end
end
