json.extract! team, :id, :team_name, :team_owner, :image, :user_id, :created_at, :updated_at
json.url team_url(team, format: :json)
