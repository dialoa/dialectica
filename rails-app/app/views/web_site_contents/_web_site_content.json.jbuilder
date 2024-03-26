json.extract! web_site_content, :id, :title, :content, :identifier, :created_at, :updated_at
json.url web_site_content_url(web_site_content, format: :json)
