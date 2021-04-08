# frozen_string_literal: true

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
