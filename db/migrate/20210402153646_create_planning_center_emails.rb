class CreatePlanningCenterEmails < ActiveRecord::Migration[6.1]
  def change
    create_table :planning_center_emails do |t|
      t.references :planning_center_person, null: false, foreign_key: true, index: true
      t.bigint :planning_center_id, unique: true, index: true
      t.string :email, unique: true, index: true

      t.timestamps
    end
  end
end
