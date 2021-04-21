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

  scope :by_first_name, ->(first_name) { where('LOWER(first_name) = ?', first_name.downcase) }
  scope :by_last_name, ->(last_name) { where('LOWER(last_name) = ?', last_name.downcase) }
  scope :by_full_name, ->(first, last) { by_first_name(first).by_last_name(last) }

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

    def by_email(email, first_name)
      return unless email

      people = joins(:planning_center_emails)
                .where('LOWER(planning_center_emails.email) = ?', email.downcase)

      return people.first if people.size == 1

      people.detect { |p| p.first_name.downcase == first_name.downcase }
    end

    def find_possible_match(donor)
      by_full_name(donor.first_name, donor.last_name)
        .or(by_last_name(donor.last_name))
        .order(last_name: :asc, first_name: :asc)
    end
  end
end
