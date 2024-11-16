json.extract! event, :id, :date, :time, :location, :host_id, :created_at, :updated_at
json.url event_url(event, format: :json)
