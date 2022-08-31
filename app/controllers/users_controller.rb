class UsersController < ApplicationController  
  def create
  end
  
  def signup
    @user = User.new
  end
end
