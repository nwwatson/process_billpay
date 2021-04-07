class AddColumnPlanningCenterPersonIdToDonors < ActiveRecord::Migration[6.1]
  def change
    add_reference :donors, :planning_center_person, null: true, foreign_key: true
  end
end
