# frozen_string_literal: true

# UsersController to create users and user's dashboard
class UsersController < ApplicationController
  def show
    render locals: {
      facade: DashboardShowFacade.new(current_user)
    }
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      user.set_confirmation_token
      user.save(validate: false)
      send_confirmation_email
    else
      flash[:error] = 'Username already exists'
      redirect_to new_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

  def send_confirmation_email
    UserMailer.registration_confirmation(current_user).deliver_now
    create_message
    redirect_to dashboard_path
  end

  def activate_message
    'This account has not yet been activated. Please check your email.'
  end

  def create_message
    flash[:success] = ["Logged in as #{current_user.first_name}"]
    flash[:success] << activate_message
  end
end
