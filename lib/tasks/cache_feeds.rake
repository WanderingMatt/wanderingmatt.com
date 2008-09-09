namespace :lifestream do
  desc "Automatically caches feed items"
  task :cache_feeds => :environment do
    puts 'Caching feeds...'
    items = Feed.cache_all
    puts 'Done!'
    unless items.empty?
      puts "Sweeping cache..."
      SiteSweeper::sweep
      puts 'Done!'
    end
  end
end