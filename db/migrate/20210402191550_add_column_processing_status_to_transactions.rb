class AddColumnProcessingStatusToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :processing_status, :integer, null: false, default: 0
  end
end
