json.extract! discussion, :id, :title, :body, :creator, :last_editor, :project_id, :created_at, :updated_at
json.url discussion_url(discussion, format: :json)
