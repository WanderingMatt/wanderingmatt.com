class CreateItemsTable < ActiveRecord::Migration
  def self.up
    create_table "items", :force => true do |t|
      t.integer :feed_id
      t.string :title, :url
      t.timestamps
    end
  end

  def self.down
    drop_table 'items'
  end
end
