json.extract! wiki, :id, :title, :body, :creator, :last_editor, :created_at, :updated_at
json.url wiki_url(wiki, format: :json)
