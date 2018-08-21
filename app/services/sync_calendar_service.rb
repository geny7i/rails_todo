class SyncCalendarService

  attr_accessor :task, :user

  CLIENT_OPTIONS = {
      client_id: ENV['GOOGLE_CLIENT_ID'],
      client_secret: ENV['GOOGLE_CLIENT_SECRET'],
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://www.googleapis.com/oauth2/v4/token',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
      redirect_uri: Rails.application.routes.url_helpers.google_auth_callback_url,
      additional_parameters: {prompt:'consent'},
    }

  def initialize(task,user)
    @task = task
    @user = user
  end

  def create_event
    client = Signet::OAuth2::Client.new(CLIENT_OPTIONS)
    client.update!(user.google_api_token)
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
    service.insert_event(user.calendar_id, calendar_event)
    rescue Google::Apis::ClientError
    refresh_token
    retry
  end

  def update_event
    client = Signet::OAuth2::Client.new(CLIENT_OPTIONS)
    client.update!(user.google_api_token)
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
    service.update_event(user.calendar_id, task.calendar_event_uid, calendar_event)
    rescue Google::Apis::ClientError
    refresh_token
    retry
  end

  def delete_event
    client = Signet::OAuth2::Client.new(CLIENT_OPTIONS)
    client.update!(user.google_api_token)
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
    service.delete_event(user.calendar_id, task.calendar_event_uid)
  end

  private

  def refresh_token
    client = Signet::OAuth2::Client.new(CLIENT_OPTIONS)
    client.update!(user.google_api_token)
    response = client.refresh!
    user.google_api_token = user.google_api_token.merge(response)
  end

  def calendar_event
    event = Google::Apis::CalendarV3::Event.new({
                                                    start: Google::Apis::CalendarV3::EventDateTime.new(date_time:task.due_at.to_datetime.rfc3339),
                                                    end: Google::Apis::CalendarV3::EventDateTime.new(date_time:(task.due_at+1.hour).to_datetime.rfc3339),
                                                    summary: task.title.to_s ,
                                                    discription: task.content.to_s,
                                                    id: task.calendar_event_uid,
                                                  })
  end
end
