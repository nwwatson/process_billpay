# frozen_string_literal: true

class PlanningCenterEmail < ApplicationRecord
  belongs_to :planning_center_person

  validates_presence_of :planning_center_id

  class << self
    def find_or_create_by_id(values)
      find_by(planning_center_id: values[:planning_center_id]) || create!(
        planning_center_id: values[:planning_center_id],
        planning_center_person: values[:planning_center_person],
        email: values[:email]
      )
    end
  end
end
