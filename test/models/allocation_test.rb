# == Schema Information
#
# Table name: allocations
#
#  id              :bigint           not null, primary key
#  donor_id        :bigint           not null
#  fund_id         :bigint           not null
#  amount          :decimal(, )
#  amount_in_cents :integer
#  frequency       :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_allocations_on_donor_id  (donor_id)
#  index_allocations_on_fund_id   (fund_id)
#
# Foreign Keys
#
#  fk_rails_...  (donor_id => donors.id)
#  fk_rails_...  (fund_id => funds.id)
#
require "test_helper"

class AllocationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
