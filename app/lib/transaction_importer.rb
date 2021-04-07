# frozen_string_literal: true

require 'CSV'

class TransactionImporter
  include Callable

  ##
  # @param from_date YYYY-MM-DD
  # @param to_date YYYY-MM-DD
  def initialize(from_date, to_date)
    @from_date = from_date
    @to_date = to_date
  end

  def call
    client = BluePay::Client.new

    client.get_transaction_report(
      report_start_date: @from_date,
      report_end_date: @to_date,
      query_by_hierarchy: '1',
      do_not_escape: '1', # Output response without commas? Yes
      exclude_errors: '1' # Do not include errored transactions? Yes
    )

    result = client.process
    record_array = CSV.parse(result, col_sep: ',')

    batch = PlanningCenter::CreateBatchCommand.call("BluePay Dontations for #{@from_date} to #{@to_date}")

    record_array.drop(1).each do |record|

      planning_center_person = PlanningCenterPerson.by_email(record[27])
      donor = Donor.find_or_create_by_email(
        first_name: record[29],
        last_name: record[30],
        address_1: record[21],
        address_2: record[22],
        city: record[23],
        state: record[24],
        zip_code: record[25],
        phone: record[26],
        email: record[27],
        planning_center_person: planning_center_person
      )

      Rails.logger.info "* PROCESSING RECORD #{record[0]}"
      unless Transaction.exists?(bluepay_id: record[0])
        Transaction.create!(
          donor: donor,
          batch: batch,
          bluepay_id: record[0],
          payment_type: record[1],
          amount: record[3],
          status: record[11],
          message: record[12],
          rebilling_id: record[17],
          settlment_id: record[18],
          bank_name: record[20],
          address_1: record[21],
          address_2: record[22],
          city: record[23],
          state: record[24],
          zip_code: record[25],
          phone: record[26],
          email: record[27],
          auth_code: record[28],
          first_name: record[29],
          last_name: record[30],
          memo: record[21],
          backend_id: record[33],
          account_id: record[44]
        )
      end
    end

    batch.transactions.unprocessed.each do |transaction|
      puts "Creating Donation #{transaction.id}"
      PlanningCenter::CreateDonationCommand.call(transaction, batch)
      sleep 1
    end
  end
end
