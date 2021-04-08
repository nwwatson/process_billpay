# frozen_string_literal: true

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
class PlanningCenterPerson < ApplicationRecord
  validates_presence_of :planning_center_id
  validates_uniqueness_of :planning_center_id

  has_many :planning_center_emails

  def full_name
    "#{first_name} #{last_name}"
  end

  def last_first
    "#{last_name}, #{first_name}"
  end

  class << self
    def find_or_create_by_id(values)
      find_by(planning_center_id: values[:planning_center_id]) || create!(
        planning_center_id: values[:planning_center_id],
        first_name: values[:first_name],
        last_name: values[:last_name]
      )
    end

    def by_email(email)
      joins(:planning_center_emails).find_by(planning_center_emails: { email: email })
    end
  end
end
