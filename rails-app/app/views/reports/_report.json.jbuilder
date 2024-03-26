json.extract! report, :id, :content, :created_at, :updated_at
json.url report_url(report, format: :json)
