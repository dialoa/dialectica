json.extract! issue, :id, :title, :published_at, :description, :created_at, :updated_at
json.url issue_url(issue, format: :json)
