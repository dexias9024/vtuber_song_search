class GuideController < ApplicationController
  skip_before_action :require_login, only: %i[about terms privacy_policy]

  def about; end
  
  def terms; end

  def privacy_policy; end
end
