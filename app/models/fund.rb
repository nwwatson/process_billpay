# frozen_string_literal: true

class Fund < ApplicationRecord
  validates :name, presence: true
  validates :planning_center_id, presence: true, uniqueness: true

  scope :by_ccb, ->(bluepay_category) { where(bluepay_category: bluepay_category)&.first }
end
