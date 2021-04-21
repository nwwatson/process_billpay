# frozen_string_literal: true

# == Schema Information
#
# Table name: funds
#
#  id                 :bigint           not null, primary key
#  name               :string
#  planning_center_id :integer
#  bluepay_category   :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Fund < ApplicationRecord
  validates :name, presence: true
  validates :planning_center_id, presence: true, uniqueness: true

  scope :by_ccb, ->(bluepay_category) { where(bluepay_category: bluepay_category)&.first }
end
