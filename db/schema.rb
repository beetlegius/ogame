# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140526120408) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cuentas", force: true do |t|
    t.date     "fecha_registro"
    t.integer  "universo_id"
    t.integer  "jugador_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cuentas", ["jugador_id"], name: "index_cuentas_on_jugador_id", using: :btree
  add_index "cuentas", ["universo_id"], name: "index_cuentas_on_universo_id", using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "edificios", force: true do |t|
    t.integer  "nivel",                 default: 0
    t.string   "type"
    t.datetime "fecha_actualizacion"
    t.integer  "proceso_id"
    t.integer  "orden"
    t.integer  "porcentaje_produccion", default: 100
    t.integer  "planeta_id"
    t.integer  "luna_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "edificios", ["luna_id"], name: "index_edificios_on_luna_id", using: :btree
  add_index "edificios", ["planeta_id"], name: "index_edificios_on_planeta_id", using: :btree

  create_table "galaxias", force: true do |t|
    t.integer  "coordenada"
    t.integer  "universo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "galaxias", ["universo_id"], name: "index_galaxias_on_universo_id", using: :btree

  create_table "jugadores", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lunas", force: true do |t|
    t.string   "nombre"
    t.integer  "planeta_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lunas", ["planeta_id"], name: "index_lunas_on_planeta_id", using: :btree

  create_table "planetas", force: true do |t|
    t.string   "nombre"
    t.integer  "temperatura_minima"
    t.integer  "temperatura_maxima"
    t.integer  "coordenada"
    t.integer  "cantidad_metal",                default: 0
    t.integer  "cantidad_cristal",              default: 0
    t.integer  "cantidad_deuterio",             default: 0
    t.integer  "cantidad_campos"
    t.datetime "ultima_actualizacion_recursos"
    t.boolean  "es_principal",                  default: false
    t.integer  "sistema_id"
    t.integer  "cuenta_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "planetas", ["cuenta_id"], name: "index_planetas_on_cuenta_id", using: :btree
  add_index "planetas", ["sistema_id"], name: "index_planetas_on_sistema_id", using: :btree

  create_table "sistemas", force: true do |t|
    t.integer  "coordenada"
    t.integer  "galaxia_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sistemas", ["galaxia_id"], name: "index_sistemas_on_galaxia_id", using: :btree

  create_table "tecnologias", force: true do |t|
    t.integer  "nivel",               default: 0
    t.string   "type"
    t.datetime "fecha_actualizacion"
    t.integer  "proceso_id"
    t.integer  "orden"
    t.integer  "cuenta_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tecnologias", ["cuenta_id"], name: "index_tecnologias_on_cuenta_id", using: :btree

  create_table "universos", force: true do |t|
    t.string   "nombre"
    t.integer  "cantidad_planetas_por_cuenta",           default: 1
    t.integer  "cantidad_construcciones_en_simultaneo",  default: 1
    t.integer  "cantidad_investigaciones_en_simultaneo", default: 1
    t.integer  "cantidad_galaxias",                      default: 1
    t.integer  "cantidad_sistemas",                      default: 1
    t.integer  "cantidad_metal_inicial",                 default: 500
    t.integer  "cantidad_cristal_inicial",               default: 500
    t.integer  "cantidad_deuterio_inicial",              default: 0
    t.integer  "puntos_protegidos",                      default: 5000
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
