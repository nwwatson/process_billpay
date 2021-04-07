class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.references :donor, null: false, foreign_key: true, index: true
      t.bigint :bluepay_id, unique: true, index: true
      t.bigint :planning_center_id
      t.string :payment_type
      t.decimal :amount
      t.string :status
      t.string :message
      t.bigint :rebilling_id
      t.bigint :settlment_id
      t.string :bank_name
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :phone
      t.string :email
      t.string :auth_code
      t.string :first_name
      t.string :last_name
      t.string :memo
      t.bigint :backend_id
      t.bigint :account_id

      t.timestamps
    end
  end
end
