# frozen_string_literal: true

module PlanningCenter
  class CreateDonationCommand
    include Callable
    include PlanningCenter::Api

    def initialize(transaction, batch, create_pc_records = true)
      @transaction = transaction
      @batch = batch
      @create_pc_records = create_pc_records
    end

    def create_pc_records?
      @create_pc_records
    end

    def call
      return false if @transaction.unprocessable?

      payload = DonationPayload.new(@transaction)

      if create_pc_records?
        response = api.giving.v2.batches[@batch.planning_center_id].donations.post(payload.payload)
        transaction.planning_center_id = response['data']['id']
      end

      transaction.status = :processed
      transaction.save!
      true
    rescue
      false
    end
  end
end
