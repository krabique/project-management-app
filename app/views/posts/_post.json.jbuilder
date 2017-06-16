json.extract! post, :id, :body, :creator, :last_editor, :discussion_id, :created_at, :updated_at
json.url post_url(post, format: :json)
