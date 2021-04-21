# == Schema Information
#
# Table name: raw_data
#
#  id         :bigint           not null, primary key
#  batch_id   :bigint           not null
#  data       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_raw_data_on_batch_id  (batch_id)
#
# Foreign Keys
#
#  fk_rails_...  (batch_id => batches.id)
#
require "test_helper"

class RawDatumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
