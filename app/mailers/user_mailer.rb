# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'register@brownfield-turing.com'

  def registration_confirmation(user)
    @user = user
    mail(to: user.email, subject: "#{user.first_name} please, confirm your account.")
  end

  def invite_by_email(user, invitee)
    @user = user
    @invitee = invitee
    mail(to: invitee[:email], subject: 'Join Brownfield')
  end
end
