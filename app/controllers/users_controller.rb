class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザーが作成されました。"
      redirect_to login_path
    else
      flash[:error] = "ユーザーの作成に失敗しました。"
      redirect_to new_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :icon, :profile)
  end
end
