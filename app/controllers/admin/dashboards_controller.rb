class Admin::DashboardsController < Admin::BaseController
  def index
    @vtuber_requests = Request.where(category: 'Vtuber').limit(5)
    @song_requests = Request.where(category: '歌').limit(20)
  end
end
