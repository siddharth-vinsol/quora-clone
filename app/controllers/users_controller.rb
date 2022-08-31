class UsersController < ApplicationController  
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to :signup, notice: 'Thank you for signing up'
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
