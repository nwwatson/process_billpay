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

class PlanningCenterPeopleControllerTest < ActionDispatch::IntegrationTest
  setup do
    @planning_center_person = planning_center_people(:one)
  end

  test "should get index" do
    get planning_center_people_url
    assert_response :success
  end

  test "should get new" do
    get new_planning_center_person_url
    assert_response :success
  end

  test "should create planning_center_person" do
    assert_difference('PlanningCenterPerson.count') do
      post planning_center_people_url, params: { planning_center_person: { email: @planning_center_person.email, first_name: @planning_center_person.first_name, last_name: @planning_center_person.last_name, planning_center_id: @planning_center_person.planning_center_id, string: @planning_center_person.string } }
    end

    assert_redirected_to planning_center_person_url(PlanningCenterPerson.last)
  end

  test "should show planning_center_person" do
    get planning_center_person_url(@planning_center_person)
    assert_response :success
  end

  test "should get edit" do
    get edit_planning_center_person_url(@planning_center_person)
    assert_response :success
  end

  test "should update planning_center_person" do
    patch planning_center_person_url(@planning_center_person), params: { planning_center_person: { email: @planning_center_person.email, first_name: @planning_center_person.first_name, last_name: @planning_center_person.last_name, planning_center_id: @planning_center_person.planning_center_id, string: @planning_center_person.string } }
    assert_redirected_to planning_center_person_url(@planning_center_person)
  end

  test "should destroy planning_center_person" do
    assert_difference('PlanningCenterPerson.count', -1) do
      delete planning_center_person_url(@planning_center_person)
    end

    assert_redirected_to planning_center_people_url
  end
end
