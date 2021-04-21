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
require "test_helper"

class FundTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
