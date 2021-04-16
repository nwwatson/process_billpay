# frozen_string_literal: true

class TransactionAllocation < ApplicationRecord
  belongs_to :donor, class_name: 'Transaction', foreign_key: 'donation_id'
  belongs_to :allocation, optional: true
  belongs_to :fund
end
