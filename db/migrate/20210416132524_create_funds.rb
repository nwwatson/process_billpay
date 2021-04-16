class CreateFunds < ActiveRecord::Migration[6.1]
  def change
    create_table :funds do |t|
      t.string :name
      t.integer :planning_center_id
      t.string :bluepay_category

      t.timestamps
    end
  end
end
