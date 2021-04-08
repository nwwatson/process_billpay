# frozen_string_literal: true

##
# SyncPcPeople
class SyncPcPeople
  include Callable

  def initialize
    @current_offset = 0
    @per_page = 100
  end

  def call
    process(PersonResponse.new(next_batch))
  end

  def process(response)
    return if response.people.length.zero?

    response.people.each do |person|
      p = PlanningCenterPerson.find_or_create_by_id(
        planning_center_id: person['id'],
        first_name: person['attributes']['first_name'],
        last_name: person['attributes']['last_name'],
      )
      emails = person['relationships']['emails']['data'] || []
      emails.each do |email|
        pc_email = response.find_email_by_id(email['id'])
        PlanningCenterEmail.find_or_create_by_id(
          planning_center_id: pc_email['id'],
          planning_center_person: p,
          email: pc_email['attributes']['address']
        )
      end
    end

    increase_offset!
    Rails.logger.info "Processing offset #{@current_offset} at #{@per_page} per page"
    process(PersonResponse.new(next_batch))
  end

  def process_batch(values)
    values['data'].each do |person|
      next unless PlanningCenterPerson.find_by(planning_center_id: person['id']).exists?

      PlanningCenterPerson.create(
        planning_center_id: person['id'],
        first_name: person['attributes']['first_name'],
        last_name: person['attributes']['last-name'],
        email: person['attributes']['me']
      )
    end
  end

  def increase_offset!
    @current_offset += @per_page
  end

  def next_batch
    api.people.v2.people.get(
      include: [:emails],
      per_page: @per_page,
      offset: @current_offset
    )
  end

  def api
    @api ||= PCO::API.new(
      basic_auth_token: Rails.application.credentials.planning_center[:application_id],
      basic_auth_secret: Rails.application.credentials.planning_center[:secret_key]
    )
  end
end
