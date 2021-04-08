# == Schema Information
#
# Table name: planning_center_people
#
#  id                 :bigint           not null, primary key
#  planning_center_id :bigint
#  first_name         :string
#  last_name          :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_planning_center_people_on_planning_center_id  (planning_center_id)
#
require "test_helper"

class PlanningCenterPersonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
