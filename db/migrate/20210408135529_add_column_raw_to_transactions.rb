class AddColumnRawToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :raw, :string
  end
end
