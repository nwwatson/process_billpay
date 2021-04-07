require "application_system_test_case"

class PlanningCenterPeopleTest < ApplicationSystemTestCase
  setup do
    @planning_center_person = planning_center_people(:one)
  end

  test "visiting the index" do
    visit planning_center_people_url
    assert_selector "h1", text: "Planning Center People"
  end

  test "creating a Planning center person" do
    visit planning_center_people_url
    click_on "New Planning Center Person"

    fill_in "Email", with: @planning_center_person.email
    fill_in "First name", with: @planning_center_person.first_name
    fill_in "Last name", with: @planning_center_person.last_name
    fill_in "Planning center", with: @planning_center_person.planning_center_id
    fill_in "String", with: @planning_center_person.string
    click_on "Create Planning center person"

    assert_text "Planning center person was successfully created"
    click_on "Back"
  end

  test "updating a Planning center person" do
    visit planning_center_people_url
    click_on "Edit", match: :first

    fill_in "Email", with: @planning_center_person.email
    fill_in "First name", with: @planning_center_person.first_name
    fill_in "Last name", with: @planning_center_person.last_name
    fill_in "Planning center", with: @planning_center_person.planning_center_id
    fill_in "String", with: @planning_center_person.string
    click_on "Update Planning center person"

    assert_text "Planning center person was successfully updated"
    click_on "Back"
  end

  test "destroying a Planning center person" do
    visit planning_center_people_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Planning center person was successfully destroyed"
  end
end
