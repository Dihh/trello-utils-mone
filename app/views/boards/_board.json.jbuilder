json.extract! board, :id, :id, :name, :user_key, :created_at, :updated_at
json.url board_url(board, format: :json)
