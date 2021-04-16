class CreateAllocations < ActiveRecord::Migration[6.1]
  def change
    create_table :allocations do |t|
      t.references :donor, null: false, foreign_key: true
      t.references :fund, null: false, foreign_key: true
      t.decimal :amount
      t.integer :amount_in_cents
      t.integer :frequency

      t.timestamps
    end
  end
end
