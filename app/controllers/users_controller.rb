# frozen_string_literal: true

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
      UserMailer.registration_confirmation(user).deliver_now
      flash[:success] = 'Please confirm your email address to continue'
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:token])
    if user
      user.validate_email
      user.save(validate: false)
      redirect_to dashboard_path
    else
      flash[:error] = 'Sorry. User does not exist'
      redirect_to root_url
  end
  end

  def invite_email
    github_handle = params[:github_handle]
    service = GithubApiService.new(current_user.github_token)
    invitee = service.invitee_email(github_handle)
    if invitee[:email]
      UserMailer.invite_by_email(current_user, invitee).deliver_now
      flash[:success] = 'Successfully sent invite!'
    else
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    end
    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
