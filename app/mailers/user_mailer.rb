# frozen_string_literal: true

# UserMailer sends registration confirmation emails and invitational emails
class UserMailer < ApplicationMailer
  default from: 'register@brownfield-turing.com'

  def registration_confirmation(user)
    @user = user
    mail(to: user.email, subject: 'Brownfield Account Activation')
  end

  def invite_by_email(user, invitee)
    @user = user
    @invitee = invitee
    mail(to: invitee[:email], subject: 'Join Brownfield')
  end
end
