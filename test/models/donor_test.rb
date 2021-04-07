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
require "test_helper"

class DonorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
