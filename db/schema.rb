# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_08_175337) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "planets", force: :cascade do |t|
    t.float "gravitational_accelaration", null: false
    t.string "name"
    t.boolean "has_fuel", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["has_fuel"], name: "index_planets_on_has_fuel", unique: true, where: "(has_fuel IS TRUE)"
    t.index ["name"], name: "unique_planets", unique: true
    t.check_constraint "gravitational_accelaration > (0)::double precision"
  end

end
