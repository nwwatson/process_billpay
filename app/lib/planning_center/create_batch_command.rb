# frozen_string_literal: true

module PlanningCenter
  class CreateBatchCommand
    include Callable
    include PlanningCenter::Api

    def initialize(description, planning_center_record = true)
      @description = description
      @planning_center_record = planning_center_record
    end

    def call
      if @planning_center_record
      response = api.giving.v2.batches.post(data: payload)
        Batch.create!(
          planning_center_id: response['data']['id'],
          description: response['data']['attributes']['description'],
          status: response['data']['attributes']['status'],
          total_cents: response['data']['attributes']['total_cents'],
          total_currency: response['data']['attributes']['total_currency']
        )
      else
        Batch.create!(
          planning_center_id: 1,
          description: @description,
          status: :fake,
          total_cents: 0,
          total_currency: 0
        )
      end
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
