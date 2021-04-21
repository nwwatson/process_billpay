# frozen_string_literal: true

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
class Allocation < ApplicationRecord
  enum frequency: { unassigned: 0, weekly: 1, bi_weekly: 2, monthly: 3, yearly: 4}

  belongs_to :donor
  belongs_to :fund

  validates :amount, presence: true
  validates :amount_in_cents, presence: true

  def frequency_from_ccb(ccb_frequency)
    self.frequency =  case ccb_frequency
                      when 'Weekly'
                        :weekly
                      when 'Every two weeks'
                        :bi_weekly
                      when 'Monthly'
                        :monthly
                      when 'Yearly'
                        :yearly
                      else
                        :unassigned
                      end
  end
end
