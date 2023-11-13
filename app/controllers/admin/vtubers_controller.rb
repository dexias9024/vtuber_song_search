class Admin::VtubersController < Admin::BaseController
  before_action :set_vtuber, only: %i[show edit update destroy]
  
  def new
    @vtuber = Vtuber.new
    @members = Member.all
    @instruments = Instrument.all
  end

  def create
    @vtuber = Vtuber.new(vtuber_params)
    if @vtuber.save
      flash[:success] = t('.success')
      redirect_to admin_vtubers_path
    else
      flash[:danger] = @vtuber.errors.full_messages
      redirect_to action: :new
    end
  end

  def index
    @vtubers = Vtuber.all
  end

  def show; end

  def edit
    @members = Member.all
    @instruments = Instrument.all
  end

  def update
    if @vtuber.update(vtuber_params)
      redirect_to admin_vtubers_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @vtuber.destroy!
    redirect_to admin_vtubers_path, success: t('.success')
  end

  private

  def set_vtuber
    @vtuber = Vtuber.find(params[:id])
  end

  def vtuber_params
    params.require(:vtuber).permit(:channel_name, :channel_url, :name, :icon, :icon_cache, :overview, :member_id, instrument_ids: [])
  end
end
