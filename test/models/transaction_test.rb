# == Schema Information
#
# Table name: transactions
#
#  id                 :bigint           not null, primary key
#  donor_id           :bigint           not null
#  bluepay_id         :bigint
#  planning_center_id :bigint
#  payment_type       :string
#  amount             :decimal(, )
#  status             :string
#  message            :string
#  rebilling_id       :bigint
#  settlment_id       :bigint
#  bank_name          :string
#  address_1          :string
#  address_2          :string
#  city               :string
#  state              :string
#  zip_code           :string
#  phone              :string
#  email              :string
#  auth_code          :string
#  first_name         :string
#  last_name          :string
#  memo               :string
#  backend_id         :bigint
#  account_id         :bigint
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  processing_status  :integer          default("unprocessed"), not null
#  batch_id           :bigint           not null
#
# Indexes
#
#  index_transactions_on_batch_id    (batch_id)
#  index_transactions_on_bluepay_id  (bluepay_id)
#  index_transactions_on_donor_id    (donor_id)
#
# Foreign Keys
#
#  fk_rails_...  (batch_id => batches.id)
#  fk_rails_...  (donor_id => donors.id)
#
require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
