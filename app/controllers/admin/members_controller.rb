class Admin::MembersController < Admin::BaseController
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

  private

  def member_params
    params.require(:member).permit(:name)
  end
end
