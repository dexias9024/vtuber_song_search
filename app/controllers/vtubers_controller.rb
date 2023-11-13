class VtubersController < ApplicationController
  def show
    @vtuber = Vtuber.find(params[:id])
  end

  def index
    @vtubers = Vtuber.all
  end
end
