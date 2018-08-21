class GoogleAuthController < ApplicationController
  def callback
    client = Signet::OAuth2::Client.new(SyncCalendarService::CLIENT_OPTIONS)
    client.code = params[:code]
    response = client.fetch_access_token!
    current_user.google_api_token = response
    calendar = Google::Apis::CalendarV3::Calendar.new({ discription: 'yosida-todo', summary:(current_user.email.sub(/@.*/, "")+'-todo')})
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
    _calendar = service.insert_calendar(calendar)
    current_user.calendar_id = _calendar.id
    current_user.save
    redirect_to tasks_path
  end

  def redirect
    client = Signet::OAuth2::Client.new(SyncCalendarService::CLIENT_OPTIONS)
    redirect_to client.authorization_uri.to_s
  end
end
