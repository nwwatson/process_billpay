class AddColumnBatchIdToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_reference :transactions, :batch, null: false, foreign_key: true
  end
end
