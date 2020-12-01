json.extract! requested_reviewer, :id, :firstname, :lastname, :email, :status, :created_at, :updated_at
json.url requested_reviewer_url(requested_reviewer, format: :json)
