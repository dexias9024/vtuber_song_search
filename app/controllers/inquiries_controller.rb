class InquiriesController < ApplicationController
  def new
    @inquiry = Inquiry.new
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      flash[:success] = t('.success')
      redirect_to inquiries_path
    else
      flash[:danger] = @inquiry.errors.full_messages
      redirect_to action: :new
    end
  end

  def index
    @inquiries = Inquiry.all.order(created_at: :desc).page(params[:page])
  end

  def show; end

  private

  def inquiry_params
    params.require(:inquiry).permit(:name, :email, :content)
  end
end
