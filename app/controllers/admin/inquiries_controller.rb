class Admin::InquiriesController < Admin::BaseController
  before_action :set_inquiry, only: %i[show close destroy]

  def index
    @inquiries = Inquiry.all.order(created_at: :desc).page(params[:page])
  end

  def show; end

  def close
    @inquiry.update(closed_at: Time.now)
    redirect_to admin_inquiries_path, success: t('.closed_successfully')
  end

  def destroy
    @inquiry.destroy!
    redirect_to admin_inquiries_path, success: t('.success')
  end

  private
  
  def set_inquiry
    @inquiry = Inquiry.find(params[:id])
  end
end
