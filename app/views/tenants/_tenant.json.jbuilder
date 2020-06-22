json.extract! tenant, :id, :name, :postal_code, :prefecture_id, :city, :address1, :address2, :created_at, :updated_at
json.url tenant_url(tenant, format: :json)
