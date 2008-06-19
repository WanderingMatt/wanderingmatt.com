# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'spec'
require 'spec/rails'

Spec::Runner.configure do |config|
  # If you're not using ActiveRecord you should remove these
  # lines, delete config/database.yml and disable :active_record
  # in your config/boot.rb
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
  
  config.include AssociationMatchers
  
  # == Fixtures
  #
  # You can declare fixtures for each example_group like this:
  #   describe "...." do
  #     fixtures :table_a, :table_b
  #
  # Alternatively, if you prefer to declare them only once, you can
  # do so right here. Just uncomment the next line and replace the fixture
  # names with your fixtures.
  #
  # config.global_fixtures = :table_a, :table_b
  #
  # If you declare global fixtures, be aware that they will be declared
  # for all of your examples, even those that don't use them.
  #
  # You can also declare which fixtures to use (for example fixtures for test/fixtures):
  #
  # config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
  #
  # == Mock Framework
  #
  # RSpec uses it's own mocking framework by default. If you prefer to
  # use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  #
  # == Notes
  # 
  # For more information take a look at Spec::Example::Configuration and Spec::Runner
end

module FeedSpecHelper
  
  def valid_feed_attributes
    {
      :name => 'Test Feed',
      :url => 'http://www.testing.co.uk/feed.rss'
    }
  end
  
  def valid_feed_params
    { 'name' => 'Testing Feed', 'url' => 'http://www.testing.com/feed.rss' }
  end
  
  def mock_xml_source
    REXML::Document.new <<SOURCE
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">
  <channel>
    <title>Twitter / andypearson</title>
    <link>http://twitter.com/andypearson</link>
    <description>Twitter updates from Andy Pearson / andypearson.</description>
    <language>en-us</language>
    <ttl>40</ttl>
    <item>
      <title>andypearson: is having fun with Delicious Library 2. http://www.delicious-monster.com/</title>
      <description>andypearson: is having fun with Delicious Library 2. http://www.delicious-monster.com/</description>
      <pubDate>Tue, 27 May 2008 15:50:14 +0000</pubDate>
      <guid>http://twitter.com/andypearson/statuses/820999889</guid>
      <link>http://twitter.com/andypearson/statuses/820999889</link>
    </item>
    <item>
      <title>andypearson: @mattbrett just go ahead and admit it, I saw The Matches live when they supported Motion City Soundtrack. Awesome show, never looked back.</title>
      <description>andypearson: @mattbrett just go ahead and admit it, I saw The Matches live when they supported Motion City Soundtrack. Awesome show, never looked back.</description>
      <pubDate>Fri, 23 May 2008 17:59:33 +0000</pubDate>
      <guid>http://twitter.com/andypearson/statuses/818504098</guid>
      <link>http://twitter.com/andypearson/statuses/818504098</link>
    </item>
    <item>
      <title>andypearson: is on his own in a freezing office. Not a fun way to spend a Monday.</title>
      <description>andypearson: is on his own in a freezing office. Not a fun way to spend a Monday.</description>
      <pubDate>Mon, 19 May 2008 11:53:30 +0000</pubDate>
      <guid>http://twitter.com/andypearson/statuses/814846813</guid>
      <link>http://twitter.com/andypearson/statuses/814846813</link>
    </item>
  </channel>
</rss>
SOURCE
  end
  
  def mock_elements
    mock_xml_source.elements
  end
  
end
