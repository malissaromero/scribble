class UsersController < ApplicationController
  skip_before_action :authenticate

  def signin
    if params[:username].strip == ""
      message = "You forgot to enter a username."
    elsif params[:password].strip == ""
      message = "You forgot to enter a password."
    else
      if !User.find_by(username: params[:username])
        if User.create(
          username: params[:username],
          password_digest: BCrypt::Password.create(params[:password].strip)
        )
          message = "Your account has been created."
        else
          message = "Your account couldn't be created. Did you enter a unique username and password?"
        end
      else
        decoded_hash = BCrypt::Password.new(User.find_by(username: params[:username]).password_digest)
        if decoded_hash.is_password?(params[:password]) == false
          message = "Your password is wrong."
        else
          message = "You're signed in, #{params[:username]}."
          cookies[:username] = {
            value: params[:username],
            expires: 1.year.from_now
          }
          session[:is_signed_in] = true
          session[:user] = User.find_by(username:params[:username])
        end
      end
    end
    flash[:sign_in_message] = message
    redirect_to :back
  end

  def signin_prompt
  end

  def signout
    reset_session
    redirect_to root_url
  end

end
