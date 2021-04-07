# frozen_string_literal: true

module PlanningCenter
  class CreateDonationCommand
    include Callable
    include PlanningCenter::Api

    def initialize(transaction, batch)
      @transaction = transaction
      @batch = batch
    end

    def call
      return false if @transaction.unprocessable?

      payload = DonationPayload.new(@transaction)
      response = api.giving.v2.batches[@batch.planning_center_id].donations.post(payload.payload)
      transaction.status = :processed
      transaction.planning_center_id = response['data']['id']
      transaction.save!
      true
    rescue
      false
    end
  end
end
