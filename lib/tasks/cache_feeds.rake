namespace :lifestream do
  desc "Automatically caches feed items"
  task :cache_feeds => :environment do
    Feed.cache_all
  end
end