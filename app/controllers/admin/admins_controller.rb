class Admin::AdminsController < Admin::BaseController
  def show
  end

  def users
    @users = User.where.not(id: current_user.id)
  end

  def questions
  end
end
