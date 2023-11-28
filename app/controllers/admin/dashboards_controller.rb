class Admin::DashboardsController < Admin::BaseController
  def index
    @requests = Request.all
  end
end
