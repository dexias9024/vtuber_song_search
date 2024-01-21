class Admin::DashboardsController < Admin::BaseController
  def index
    @vtuber_requests = Request.where(category: 'Vtuber').limit(10)
    @song_requests = Request.where(category: '歌').limit(100).page(params[:page])
  end
end
