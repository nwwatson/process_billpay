class AddColumnsToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :issue_date, :datetime
    add_column :transactions, :settle_date, :datetime
  end
end
