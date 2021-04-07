# == Schema Information
#
# Table name: donors
#
#  id         :bigint           not null, primary key
#  name       :string
#  address_1  :string
#  address_2  :string
#  zip_code   :string
#  phone      :string
#  email      :string
#  bluepay_id :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Donor < ApplicationRecord
  belongs_to :planning_center_person, optional: true
  has_many :transactions

  validates_presence_of :email

  def full_name
    "#{first_name} #{last_name}"
  end

  def processable?
    planning_center_person.present?
  end

  class << self
    def find_or_create_by_email(values = {})
      find_by(email: values[:email]) || create!(values)
    rescue
      donor = Donor.new(values)
      donor.save!(validate: false)
      donor
    end
  end
end
