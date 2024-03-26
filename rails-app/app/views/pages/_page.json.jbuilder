json.extract! page, :id, :title, :description, :keywords, :search_field, :created_at, :updated_at
json.url page_url(page, format: :json)
