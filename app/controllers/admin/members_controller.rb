class Admin::MembersController < Admin::BaseController
  def index
    @members = Member.all.page(params[:page])
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(member_params)
    if @member.save
      flash[:success] = t('.success')
      redirect_to admin_root_path
    else
      flash[:danger] = @member.errors.full_messages
      redirect_to action: :new
    end
  end

  def destroy
    @member = Member.find(params[:id])

    ActiveRecord::Base.transaction do
      if @member.oldest_member?
        redirect_to admin_members_path, danger: t('.oldest_member_error')
      else
        @member.update_vtubers if @member
        @member.destroy!
        redirect_to admin_members_path, success: t('.success')
      end
    end
  end

  private

  def member_params
    params.require(:member).permit(:name)
  end
end
