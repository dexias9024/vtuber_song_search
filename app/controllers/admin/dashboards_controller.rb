class Admin::DashboardsController < Admin::BaseController
  def index
    @user_requests = UserRequest.all
  end
end
