# == Schema Information
#
# Table name: donors
#
#  id                        :bigint           not null, primary key
#  first_name                :string
#  last_name                 :string
#  address_1                 :string
#  address_2                 :string
#  city                      :string
#  state                     :string
#  zip_code                  :string
#  phone                     :string
#  email                     :string
#  bluepay_id                :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  planning_center_person_id :bigint
#
# Indexes
#
#  index_donors_on_planning_center_person_id  (planning_center_person_id)
#
# Foreign Keys
#
#  fk_rails_...  (planning_center_person_id => planning_center_people.id)
#
require "test_helper"

class DonorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
