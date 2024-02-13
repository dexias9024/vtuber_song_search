class Admin::InquiriesController < Admin::BaseController
  before_action :set_inquiry, only: %i[show close destroy]

  def index
    @inquiries = Inquiry.all.order(created_at: :desc).page(params[:page])
  end

  def show; end

  def close
    if @inquiry.update_columns(closed_at: Time.now)
      redirect_to admin_inquiries_path, success: t('.closed_successfully')
    else
      Rails.logger.error("Failed to close inquiry. Errors: #{@inquiry.errors.full_messages}")
      flash[:danger] = t('.fail')
      redirect_to admin_inquiries_path
    end
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
