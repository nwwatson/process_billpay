class SubmitDonation
  include Callable

  def initialize(transaction)
    @transaction = transaction
  end

  def call
    return if @transaction.processed?

    payload = DonationPayload.new(@transaction)
    api.giving.v2.donations.post(payload.payload)
  end

  private

  def api
    @api ||= PCO::API.new(
      basic_auth_token: Rails.application.credentials.planning_center[:application_id],
      basic_auth_secret: Rails.application.credentials.planning_center[:secret_key]
    )
  end
end
