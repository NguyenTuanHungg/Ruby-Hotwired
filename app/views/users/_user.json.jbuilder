json.extract! user, :id, :name, :mentor,  :skills, :payment, :time, :status, :created_at, :updated_at
json.url user_url(user, format: :json)
