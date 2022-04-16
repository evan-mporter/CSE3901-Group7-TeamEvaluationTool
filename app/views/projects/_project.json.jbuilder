json.extract! project, :id, :name, :is_open, :created_at, :updated_at
json.url project_url(project, format: :json)
