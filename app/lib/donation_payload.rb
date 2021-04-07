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
          "received_at": "2017-10-10"
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
      "included": [
        {
          "type": "Designation",
          "attributes": { "amount_cents": @transaction.amount_in_cents },
          "relationships": {
            "fund": {
              "data": { "type": "Fund", "id": "185489" }
            }
          }
        }
      ]
    }
  end
end
