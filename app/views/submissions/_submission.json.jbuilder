json.extract! submission, :id, :title, :area, :firstname, :lastname, :created_at, :updated_at
json.url submission_url(submission, format: :json)
