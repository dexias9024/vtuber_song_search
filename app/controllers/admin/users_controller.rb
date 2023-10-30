class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :check_owner, only: %i[show edit update destroy]
  
  def index
    @users = User.all
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, success: 'User was successfully updated.'
    else
      flash.now[:danger] = 'User update failed.'
      render :edit
    end
  end

  def destroy
    @user.destroy!
    redirect_to admin_users_path, success: 'ユーザーを削除しました。'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :icon, :profile, :role)
  end

  def check_owner
    return unless @user == current_user

    redirect_to admin_root_path
  end
end
