class SessionsController < ApplicationController

  def new
   @user = User.new
  end

  def create
    user = User.where(email: params[:user][:email]).first
    # Checks to see if the user exists, and then for a matching password
    if user && user.authenticate(params[:user][:password])
      # Creates a cookie for the user, holding the logged in user ID
      session[:user_id] = user.id.to_s
      if current_user.is_admin
        redirect_to boards_path
      else
        redirect_to user_path(current_user)
      end
    else
      flash[:error] = "Email or Password do not match! Please try again"
      redirect_to main_path

    end
  end

  def destroy
    # Kill all of our cookies
    reset_session
    redirect_to main_path
  end
end
