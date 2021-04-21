# frozen_string_literal: true

# == Schema Information
#
# Table name: transaction_allocations
#
#  id              :bigint           not null, primary key
#  donation_id     :integer          not null
#  allocation_id   :bigint
#  fund_id         :bigint           not null
#  amount          :decimal(, )      not null
#  amount_in_cents :decimal(, )      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_transaction_allocations_on_allocation_id  (allocation_id)
#  index_transaction_allocations_on_donation_id    (donation_id)
#  index_transaction_allocations_on_fund_id        (fund_id)
#
# Foreign Keys
#
#  fk_rails_...  (allocation_id => allocations.id)
#  fk_rails_...  (fund_id => funds.id)
#
class TransactionAllocation < ApplicationRecord
  belongs_to :donor, class_name: 'Transaction', foreign_key: 'donation_id'
  belongs_to :allocation, optional: true
  belongs_to :fund
end
