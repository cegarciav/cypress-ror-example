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

  def create
    new_user_params = params.permit(
      :email,
      :name,
      :username,
      :password,
      :password2,
      :authenticity_token,
      :commit
    )

    if new_user_params[:password] != new_user_params[:password2]
      flash[:notice] = 'Passwords don\'t match'
      redirect_to '/signup'
    elsif new_user_params[:password].length < 8
      flash[:notice] = 'Password must be at least 8 characters long'
      redirect_to '/signup'
    elsif User.find_by(email: new_user_params[:email])
      flash[:notice] = 'Email already registered'
      redirect_to '/signup'
    elsif User.find_by(username: new_user_params[:username])
      flash[:notice] = 'Username already registered'
      redirect_to '/signup'
    else
      begin
        @user = User.create!(
          email: new_user_params[:email],
          name: new_user_params[:name],
          username: new_user_params[:username],
          password: new_user_params[:password]
        )
        session[:username] = @user.username
        redirect_to '/'
      rescue
        flash[:notice] = 'Invalid email'
        redirect_to '/signup'
      end
    end
  end

  def login
    if session[:username] && User.find_by(username: session[:username])
      redirect_to '/'
    end
  end

  def signup
    if session[:username] && User.find_by(username: session[:username])
      redirect_to '/'
    end
  end
end
