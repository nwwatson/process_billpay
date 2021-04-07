# frozen_string_literal: true

module PlanningCenter
  class DeleteBatchCommand
    include Callable
    include PlanningCenter::Api

    def initialize(bucket)
      @bucket = bucket
    end

    def call
      api.giving.v2.batches[@bucket.planning_center_id].delete
    end
  end
end
