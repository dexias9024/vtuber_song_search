class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :set_user, only: %i[show]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t('.success')
      redirect_to login_path
    else
      flash[:danger] = @user.errors.full_messages
      redirect_to action: :new
    end
  end

  def show; end

  def edit; end

  def update
    if current_user.update(user_params)
      redirect_to songs_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :icon, :profile)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
