class CreateRawData < ActiveRecord::Migration[6.1]
  def change
    create_table :raw_data do |t|
      t.references :batch, null: false, foreign_key: true
      t.string :data

      t.timestamps
    end
  end
end
