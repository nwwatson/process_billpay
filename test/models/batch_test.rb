# == Schema Information
#
# Table name: batches
#
#  id                 :bigint           not null, primary key
#  planning_center_id :bigint           not null
#  description        :string
#  committed_at       :datetime
#  total_cents        :integer
#  total_currency     :string
#  status             :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_batches_on_planning_center_id  (planning_center_id)
#
require "test_helper"

class BatchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
