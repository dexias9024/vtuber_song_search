class Admin::VtubersController < Admin::BaseController
  before_action :set_vtuber, only: %i[show edit update destroy]
  before_action :set_members, only: %i[new show edit update]
  before_action :set_instruments, only: %i[new show edit update destroy]
  
  def new
    @vtuber = Vtuber.new
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
    @vtubers = Vtuber.all.order(created_at: :desc).page(params[:page])
  end

  def show; end

  def edit; end

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

  def set_members
    @members = Member.all
  end

  def set_instruments
    @instruments = Instrument.all
  end

  def vtuber_params
    params.require(:vtuber).permit(:channel_name, :channel_url, :name, :icon, :icon_cache, :overview, :member_id, instrument_ids: [])
  end
end
