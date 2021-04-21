# frozen_string_literal: true

##
# data rake task
#
# The data rake tasks imports data from planning center and
# processes transactions
namespace :data do
  task :planning_center, [] => :environment do
    SyncPcPeople.call
  end

  task :import_donors, [] => :environment do
    from_date = Time.now.beginning_of_year
    to_date = from_date.end_of_week

    while to_date < Time.now
      puts "Processing from #{from_date.strftime('%Y-%m-%d')} to #{to_date.strftime('%Y-%m-%d')}"
      TransactionImporter.call(
        from_date.strftime('%Y-%m-%d'),
        to_date.strftime('%Y-%m-%d'),
        create_transactions: false
      )
      sleep 1
      from_date = to_date + 1.day
      to_date = from_date.end_of_week
    end
  end

  task :transactions, [] => :environment do
    #if Time.now.in_time_zone.monday?
      puts "It's monday, lets run it"
      from_date = Time.now.last_week.beginning_of_week
      to_date = from_date.end_of_week
      TransactionImporter.call(from_date, to_date, create_pc_records: Rails.env.production?)
    #else
    #  puts "It's not monday"
    #end
  end

  task :update_donors, [] => :environment do
    #SyncPcPeople.call

    Donor.invalid.each do |donor|
      unless donor.planning_center_person_id
        planning_center_person = PlanningCenterPerson.by_email(donor.email, donor.first_name)
        donor.planning_center_person = planning_center_person
        donor.save!
      end
    end
  end

  task :import_allocations, [] => :environment do
    AllocationImporter.call
  end
end
