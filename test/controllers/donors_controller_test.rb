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

class DonorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @donor = donors(:one)
  end

  test "should get index" do
    get donors_url
    assert_response :success
  end

  test "should get new" do
    get new_donor_url
    assert_response :success
  end

  test "should create donor" do
    assert_difference('Donor.count') do
      post donors_url, params: { donor: {  } }
    end

    assert_redirected_to donor_url(Donor.last)
  end

  test "should show donor" do
    get donor_url(@donor)
    assert_response :success
  end

  test "should get edit" do
    get edit_donor_url(@donor)
    assert_response :success
  end

  test "should update donor" do
    patch donor_url(@donor), params: { donor: {  } }
    assert_redirected_to donor_url(@donor)
  end

  test "should destroy donor" do
    assert_difference('Donor.count', -1) do
      delete donor_url(@donor)
    end

    assert_redirected_to donors_url
  end
end
