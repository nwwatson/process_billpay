class CreateBatches < ActiveRecord::Migration[6.1]
  def change
    create_table :batches do |t|
      t.bigint :planning_center_id, null: false, unique: true, index: true
      t.string :description
      t.datetime :committed_at
      t.integer :total_cents
      t.string :total_currency
      t.integer :status

      t.timestamps
    end
  end
end
