# frozen_string_literal: true

class DonationPayload

  def initialize(transaction)
    @transaction = transaction
  end

  def payload
    {
      "data": {
        "type": "Donation",
        "attributes": {
          "payment_method": "ach",
          "received_at": @transaction.issue_date.strftime('%Y-%m-%d')
        },
        "relationships": {
          "person": {
            "data": { "type": "Person", "id": @transaction.donor.planning_center_person.planning_center_id}
          },
          "payment_source": {
            "data": { "type": "PaymentSource", "id": "13109" }
          },
        }
      },
      "included": designations
    }
  end

  def designations
    @transaction.transaction_allocations.includes(:fund).collect do |allocation|
      {
        "type": "Designation",
        "attributes": { "amount_cents": allocation.amount_in_cents },
        "relationships": {
          "fund": {
            "data": { "type": "Fund", "id": allocation.fund.planning_center_id }
          }
        }
      }
    end
  end
end
