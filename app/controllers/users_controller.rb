class UsersController < ApplicationController  
  def create
    @user = User.new(user_params)
    @user.verified = SecureRandom.uuid

    if @user.save
      redirect_to login_path, notice: 'Thank you for signing up, a verification email has been sent to your account.'
    else
      render :signup, status: :unprocessable_entity
    end
  end

  def signup
    @user = User.new
  end

  private def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
