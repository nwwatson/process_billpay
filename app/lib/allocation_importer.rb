# frozen_string_literal: true

require 'csv'

##
# AllocationImporter
#
# CSV COLUMNS
#  0  Ind ID
#  1  Name
#  2  Phone
#  3  Email
#  4  COA Category
#  5  Amount Each Time
#  6  Next
#  7  Frequency
#  8  Remaining
#  9  Last Msg
#  10 Pay Type,
#  11 Merchant Schedule ID
#  12 Merchant Trans ID
#  13 Merchant Auth Code
class AllocationImporter
  include Callable

  def call
    puts '*' * 80
    puts 'Creating Companies'
    puts '*' * 80
    allocations = CSV.read(Rails.root.join('data', 'repeat_gifts_schedule.csv'))
    errors = 0
    successful = 0

    allocations.drop(1).each do |allocation|
      donor = Donor.find_by(email: allocation[3])
      fund = Fund.find_by(bluepay_category: allocation[4])

      if donor && fund
        next if Allocation.where(donor: donor, fund: fund).exists?

        amount_to_allocate = BigDecimal(allocation[5].tr('$,',''))
        a = Allocation.new(
          donor: donor,
          fund: fund,
          amount: amount_to_allocate,
          amount_in_cents: amount_to_allocate * 100
        )
        a.frequency_from_ccb allocation[7]
        a.save!
        successful += 1
      else
        puts '*' * 80
        puts '* Unable to process allocation!!!'
        puts "* allocation: #{allocation[0]}"
        puts "* donor: #{allocation[3]}"
        puts "* donor: #{allocation[4]}"
        puts '*' * 80
        puts ''
        errors += 1
      end
    end

    puts ''
    puts '*' * 80
    puts "* Total Records #{allocations.length - 1}"
    puts "* Sucessful: #{successful}"
    puts "* Errors: #{errors}"
    puts '*' * 80
    puts ''

  end
end
