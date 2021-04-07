# frozen_string_literal: true

module PlanningCenter
  module Api
    extend ActiveSupport::Concern

    def api
      @api ||= PCO::API.new(
        basic_auth_token: Rails.application.credentials.planning_center[:application_id],
        basic_auth_secret: Rails.application.credentials.planning_center[:secret_key]
      )
    end
  end
end
