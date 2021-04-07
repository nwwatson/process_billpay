# frozen_string_literal: true

namespace :app do
  task :rebuild, [] => :environment do
    raise 'Not allowed to run on production' if Rails.env.production?
    ActiveRecord::Base.connection.execute('SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE datname = current_database() AND pid <> pg_backend_pid();')
    Rake::Task['db:drop'].execute
    Rake::Task['db:create'].execute
    Rake::Task['db:migrate'].execute
    Rake::Task['db:seed'].execute
    Rake::Task['db:test:prepare'].execute
  end

  task :seed, [] => :environment do
    Rake::Task['db:seed'].execute
  end
end
