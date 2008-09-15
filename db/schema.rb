# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080915185016) do

  create_table "feeds", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "cached_at"
    t.boolean  "active",     :default => false
    t.string   "permalink"
    t.boolean  "visible"
  end

  create_table "images", :force => true do |t|
    t.string   "title"
    t.string   "path"
    t.string   "name"
    t.text     "source_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "source_image_url"
  end

  create_table "items", :force => true do |t|
    t.integer  "feed_id",      :limit => 11
    t.string   "title"
    t.text     "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "tags"
    t.datetime "published_at"
    t.datetime "cached_at"
    t.integer  "image_id",     :limit => 11
  end

end
