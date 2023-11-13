class Admin::InstrumentsController < Admin::BaseController
  def new
    @instrument = Instrument.new
  end

  def create
    @instrument = Instrument.new(instrument_params)
    if @instrument.save
      flash[:success] = t('.success')
      redirect_to admin_root_path
    else
      flash[:danger] = @instrument.errors.full_messages
      redirect_to action: :new
    end
  end

  private

  def instrument_params
    params.require(:instrument).permit(:name)
  end
end
