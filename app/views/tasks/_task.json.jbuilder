json.extract! task, :id, :title, :content, :due_at, :user_id, :created_at, :updated_at
json.url task_url(task, format: :json)
