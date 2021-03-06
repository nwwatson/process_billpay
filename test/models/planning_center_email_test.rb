# == Schema Information
#
# Table name: planning_center_emails
#
#  id                        :bigint           not null, primary key
#  planning_center_person_id :bigint           not null
#  planning_center_id        :bigint
#  email                     :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
# Indexes
#
#  index_planning_center_emails_on_email                      (email)
#  index_planning_center_emails_on_planning_center_id         (planning_center_id)
#  index_planning_center_emails_on_planning_center_person_id  (planning_center_person_id)
#
# Foreign Keys
#
#  fk_rails_...  (planning_center_person_id => planning_center_people.id)
#
require "test_helper"

class PlanningCenterEmailTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
