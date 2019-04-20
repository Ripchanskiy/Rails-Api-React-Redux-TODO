class Api::V1::UsersController < ApplicationController
  def register
    user = User.new(user_param)
    if user.save
      render json: user
    else
      render json: user.errors, status: 422
    end
  end

  def login
    command = AuthenticateUser.call(login_param)
    if command.success?
      render json: { access_token: command.access_token,
                     message: 'Login Successful' }
    else
      render json: 'Invalid credentials', status: 422
    end
  end

  private

  def user_param
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
  
  def login_param
    params.require(:user).permit(:email, :password)
  end
end