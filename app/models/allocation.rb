# frozen_string_literal: true

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
