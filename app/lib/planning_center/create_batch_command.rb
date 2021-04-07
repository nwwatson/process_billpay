# frozen_string_literal: true

module PlanningCenter
  class CreateBatchCommand
    include Callable
    include PlanningCenter::Api

    def initialize(description)
      @description = description
    end

    def call
      response = api.giving.v2.batches.post(data: payload)
      Batch.create!(
        planning_center_id: response['data']['id'],
        description: response['data']['attributes']['description'],
        status: response['data']['attributes']['status'],
        total_cents: response['data']['attributes']['total_cents'],
        total_currency: response['data']['attributes']['total_currency']
      )
    end

    def payload
      {
        type: 'Batch',
        attributes: {
          description: @description
        }
      }
    end
  end
end
