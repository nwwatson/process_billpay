# == Schema Information
#
# Table name: transactions
#
#  id           :bigint           not null, primary key
#  donor_id     :bigint           not null
#  bluepay_id   :bigint
#  payment_type :string
#  amount       :decimal(, )
#  status       :string
#  message      :string
#  rebilling_id :bigint
#  settlment_id :bigint
#  bank_name    :string
#  address_1    :string
#  address_2    :string
#  city         :string
#  state        :string
#  zip_code     :string
#  phone        :string
#  email        :string
#  auth_code    :string
#  first_name   :string
#  last_name    :string
#  memo         :string
#  backend_id   :bigint
#  account_id   :bigint
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_transactions_on_donor_id  (donor_id)
#
# Foreign Keys
#
#  fk_rails_...  (donor_id => donors.id)
#
class Transaction < ApplicationRecord
  enum processing_status: { unprocessed: 0, processed: 1, unprocessable: 2 }

  belongs_to :batch, optional: true
  belongs_to :donor

  before_save :update_processability

  def update_processability
    self.processing_status = :unprocessable unless donor.processable?
  end

  def amount_in_cents
    amount * 100
  end
end
