class AddCalendarIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :google_api_token, :text
    add_column :users, :calendar_id, :string
  end
end
