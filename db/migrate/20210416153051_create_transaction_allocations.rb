class CreateTransactionAllocations < ActiveRecord::Migration[6.1]
  def change
    create_table :transaction_allocations do |t|
      t.integer :donation_id, null: false, index: true
      t.references :allocation, null: true, foreign_key: true
      t.references :fund, null: false, foreign_key: true
      t.decimal :amount, null: false, foreign_key: true
      t.decimal :amount_in_cents, null: false, foreign_key: true

      t.timestamps
    end

    #add_index :transaction_allocations, :transaction_id
    #add_index :transaction_allocations, :allocation_id
    #add_index :transaction_allocations, :fund_id
  end
end
