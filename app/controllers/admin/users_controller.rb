class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :check_owner, only: %i[show edit update destroy]
  
  def index
    if search_params[:search].present?
      hiragana = search_params[:search].tr('ァ-ン', 'ぁ-ん')
      katakana = search_params[:search].tr('ぁ-ん', 'ァ-ン')

      search_users = User.search_by_name(search_params[:search]).order(created_at: :desc)
      hiragana_users = User.search_by_name(hiragana).order(created_at: :desc)
      katakana_users = User.search_by_name(katakana).order(created_at: :desc)
      result_users = (search_users + hiragana_users + katakana_users).uniq
      @users = Kaminari.paginate_array(result_users).page(params[:page]).per(20)
    else
      @users = User.all.order(created_at: :desc).page(params[:page])
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!
    redirect_to admin_users_path, success: t('.success')
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :icon, :icon_cache, :profile, :role)
  end

  def check_owner
    return unless @user == current_user

    redirect_to admin_root_path
  end

  def search_params
    params.permit(:search, :name)
  end
end
