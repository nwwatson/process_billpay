# frozen_string_literal: true

require 'csv'

class TransactionImporter
  include Callable

  ##
  # @param from_date YYYY-MM-DD
  # @param to_date YYYY-MM-DD
  def initialize(from_date, to_date, options = {})
    @from_date = from_date
    @to_date = to_date
    @create_pc_records = options.fetch(:create_pc_records, true)
    @create_transactions = options.fetch(:create_transactions, true)
  end

  def create_pc_records?
    @create_pc_records
  end

  def transaction_from_date
    @from_date.strftime('%Y-%m-%d')
  end

  def transaction_to_date
    (@to_date + 1.day).strftime('%Y-%m-%d')
  end

  def create_transactions?
    @create_transactions
  end

  def call
    client = BluePay::Client.new

    client.get_transaction_report(
      report_start_date: transaction_from_date,
      report_end_date: transaction_to_date,
      query_by_hierarchy: '1',
      do_not_escape: '1', # Output response without commas? Yes
      exclude_errors: '1' # Do not include errored transactions? Yes
    )

    result = client.process
    record_array = CSV.parse(result, col_sep: ',')

    batch = if create_transactions?
              PlanningCenter::CreateBatchCommand.call("BluePay Dontations for #{@transaction_from_date} to #{@to_date.strftime('%Y-%m-%d')}", create_pc_records?)
            end

    RawDatum.create(batch: batch, data: result)

    record_array.drop(1).each do |record|

      planning_center_person = PlanningCenterPerson.by_email(record[27], record[29])
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

      puts ''
      puts "* Processing donation for #{donor.first_name} #{donor.last_name}"

      next unless create_transactions?

      next if Transaction.exists?(bluepay_id: record[0])

      transaction = Transaction.create!(
        donor: donor,
        batch: batch,
        bluepay_id: record[0],
        payment_type: record[1],
        amount: record[3],
        status: record[11],
        message: record[12],
        issue_date: record[15] ? DateTime.parse("#{record[15]} -0400") : nil,
        settle_date: record[16] ? DateTime.parse("#{record[16]} -0400") : nil,
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
        account_id: record[44],
        raw: record.to_s.gsub(/\"/, '\'').gsub(/[\[\]]/, '')
      )

      puts "* Donor allocations? #{donor.allocations.any?}"
      puts "* Transaction Amount: #{transaction.amount_in_cents.to_i}"
      puts "* Donor Allcations: #{donor.total_allocations}"
      if transaction.amount_in_cents == donor.total_allocations
        puts '* Donor allocations equal donation amount'
        donor.allocations.each do |allocation|
          puts "* Allocating #{allocation.amount} to fund #{allocation.fund.name}"
          transaction.transaction_allocations.create!(
            allocation: allocation,
            fund: allocation.fund,
            amount: allocation.amount,
            amount_in_cents: allocation.amount_in_cents
          )
        end
      else
        puts '* Donor allocaitons DO NOT EQUAL donation amount'
        puts "* Allocating #{transaction.amount} to fund General Fund"
        transaction.transaction_allocations.create!(
          fund: Fund.find_by(planning_center_id: 185489),
          amount: transaction.amount,
          amount_in_cents: transaction.amount_in_cents
        )
      end
      puts ''
    end

    return unless create_transactions? && create_pc_records?

    batch.transactions.unprocessed.each do |transaction|
      puts "Creating Donation #{transaction.id}"
      PlanningCenter::CreateDonationCommand.call(transaction, batch)
      sleep 1
    end
  end
end
