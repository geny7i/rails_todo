class ApplicationController < ActionController::Base
  private
  def check_calendar_info
    redirect_to google_auth_redirect_path if current_user.calendar_id.blank?
  end
end
