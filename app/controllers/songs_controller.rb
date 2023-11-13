class SongsController < ApplicationController
  def index
    @vtubers = Vtuber.all
  end
end
