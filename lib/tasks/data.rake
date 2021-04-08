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

  task :transactions, [] => :environment do
    from_date = Time.now.beginning_of_week.strftime('%Y-%m-%d')
    to_date = Time.now.strftime('%Y-%m-%d')
    TransactionImporter.call(from_date, to_date, true)
  end
end
