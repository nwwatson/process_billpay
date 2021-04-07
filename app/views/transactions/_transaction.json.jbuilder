json.extract! transaction, :id, :bluepay_id, :payment_type, :amount, :status, :message, :rebilling_id, :settlment_id, :bank_name, :address_1, :address_2, :city, :state, :zip_code, :phone, :email, :auth_code, :first_name, :last_name, :memo, :backend_id, :account_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
