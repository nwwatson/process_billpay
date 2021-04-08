# frozen_string_literal: true

module DonorsHelper
  include CacheConcern

  def planning_center_people_list
    @planning_center_people_list ||= retrieve_cache('planning_center_people_list') do
      PlanningCenterPerson.all.order(:last_name, :first_name).map { |o| ListItem.new(o.id, o.last_first) }
    end
  end
end
