# frozen_string_literal: true

class PersonResponse
  def initialize(response)
    @response = response
  end

  def people
    @response["data"]
  end

  def emails
    @emails ||= @response["included"].select { |hash| hash["type"] == "Email" }
  end

  def find_email_by_id(id)
    emails.select { |hash| hash["id"] == id.to_s }&.first
  end
end
