class VtubersController < ApplicationController
  def show
    @vtuber = Vtuber.find(params[:id])
  end

  def index
    @vtubers = Vtuber.all.order(created_at: :desc).page(params[:page])
  end
end
