json.extract! batch, :id, :description, :committed_at, :total_cents, :total_currency, :status, :created_at, :updated_at
json.url batch_url(batch, format: :json)
