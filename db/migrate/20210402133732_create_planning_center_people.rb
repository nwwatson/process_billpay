class CreatePlanningCenterPeople < ActiveRecord::Migration[6.1]
  def change
    create_table :planning_center_people do |t|
      t.bigint :planning_center_id, unique: true, index: true
      t.string :first_name
      t.string :last_name
      t.timestamps
    end
  end
end
