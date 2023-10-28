class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create guest_login]

  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user&.admin?
      logout
      flash.now[:danger] = "ログインに失敗しました."
      redirect_to login_path
    elsif @user
      flash[:success] = "ログインしました。"
      redirect_to songs_path
    else
      flash.now[:danger] = "ログインに失敗しました."
      render :new
    end
  end

  def destroy
    logout
    flash[:success] = "ログアウトしました。"
    redirect_to login_path
  end

  def guest_login
    @guest_user = User.create(
    name: 'ゲスト',
    email: SecureRandom.uuid + "@email.com",
    password: 'password',
    password_confirmation: 'password',
    role: 'guest'
    )
    auto_login(@guest_user)
    flash[:success] = "ゲストとしてログインしました。"
    redirect_to songs_path
  end
end
