namespace :data do

  task :populate, [] => :environment do
    account = Account.find(1)
    feed = "https://vimeo.com/showcase/6978987/feed/roku/b7b8533041"

    ImportVimeoService.call(account, feed)
  end
end