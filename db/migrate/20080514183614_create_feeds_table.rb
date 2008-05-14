class CreateFeedsTable < ActiveRecord::Migration
  def self.up
    create_table "feeds", :force => true do |t|
      t.string :name, :url
      t.timestamps
    end
  end

  def self.down
    drop_table "feeds"
  end
end
