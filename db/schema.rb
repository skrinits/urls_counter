# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_18_113911) do

  create_table "urls", force: :cascade do |t|
    t.string "short_version"
    t.string "full_version"
    t.integer "request_counter", default: 0
    t.index ["full_version"], name: "index_urls_on_full_version", unique: true
    t.index ["short_version"], name: "index_urls_on_short_version", unique: true
  end

end
