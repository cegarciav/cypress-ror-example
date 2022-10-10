class UsersController < ApplicationController
  def check_credentials
    session_params = params.permit(
      :username,
      :password,
      :authenticity_token,
      :commit
    )
    @email_user = User.find_by(email: session_params[:username])
    if @email_user
      @user = @email_user
    else
      @user = User.find_by(username: session_params[:username])
    end
    
    if @user
      if @user.password == session_params[:password]
        session[:username] = @user.username
        redirect_to '/'
      else
        flash[:notice] = 'Invalid credentials!'
        redirect_to '/login'
      end
    else
      flash[:notice] = 'User not found!'
      redirect_to '/login'
    end
  end

  def login
    if session[:username] && User.find_by(username: session[:username])
      redirect_to '/'
    end
  end
end
