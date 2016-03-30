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

ActiveRecord::Schema.define(version: 20140611015236) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cuentas", force: :cascade do |t|
    t.date     "fecha_registro"
    t.integer  "nivel_tecnologia_blindaje",                default: 0
    t.integer  "nivel_tecnologia_combustion",              default: 0
    t.integer  "nivel_tecnologia_computacion",             default: 0
    t.integer  "nivel_tecnologia_defensa",                 default: 0
    t.integer  "nivel_tecnologia_energia",                 default: 0
    t.integer  "nivel_tecnologia_espionaje",               default: 0
    t.integer  "nivel_tecnologia_graviton",                default: 0
    t.integer  "nivel_tecnologia_hiperespacio",            default: 0
    t.integer  "nivel_tecnologia_impulso",                 default: 0
    t.integer  "nivel_tecnologia_ionica",                  default: 0
    t.integer  "nivel_tecnologia_laser",                   default: 0
    t.integer  "nivel_tecnologia_militar",                 default: 0
    t.integer  "nivel_tecnologia_plasma",                  default: 0
    t.integer  "nivel_tecnologia_propulsor_hiperespacial", default: 0
    t.integer  "nivel_tecnologia_red_investigacion",       default: 0
    t.integer  "universo_id"
    t.integer  "jugador_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cuentas", ["jugador_id"], name: "index_cuentas_on_jugador_id", using: :btree
  add_index "cuentas", ["universo_id"], name: "index_cuentas_on_universo_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",         default: 0, null: false
    t.integer  "attempts",         default: 0, null: false
    t.text     "handler",                      null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.integer  "propietario_id"
    t.string   "propietario_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  add_index "delayed_jobs", ["propietario_type", "propietario_id"], name: "index_delayed_jobs_on_propietario_type_and_propietario_id", using: :btree

  create_table "jugadores", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lunas", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "planeta_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lunas", ["planeta_id"], name: "index_lunas_on_planeta_id", using: :btree

  create_table "planetas", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "temperatura_minima"
    t.integer  "temperatura_maxima"
    t.integer  "numero_galaxia"
    t.integer  "numero_sistema"
    t.integer  "numero_planeta"
    t.integer  "nivel_mina_metal",                     default: 0
    t.integer  "nivel_mina_cristal",                   default: 0
    t.integer  "nivel_mina_deuterio",                  default: 0
    t.integer  "nivel_planta_energia",                 default: 0
    t.integer  "nivel_planta_fusion",                  default: 0
    t.integer  "nivel_fabrica_robots",                 default: 0
    t.integer  "nivel_fabrica_nanobots",               default: 0
    t.integer  "nivel_hangar",                         default: 0
    t.integer  "nivel_almacen_metal",                  default: 0
    t.integer  "nivel_almacen_cristal",                default: 0
    t.integer  "nivel_almacen_deuterio",               default: 0
    t.integer  "nivel_laboratorio",                    default: 0
    t.integer  "nivel_silo",                           default: 0
    t.integer  "porcentaje_produccion_mina_metal",     default: 100
    t.integer  "porcentaje_produccion_mina_cristal",   default: 100
    t.integer  "porcentaje_produccion_mina_deuterio",  default: 100
    t.integer  "porcentaje_produccion_planta_energia", default: 100
    t.integer  "porcentaje_produccion_planta_fusion",  default: 100
    t.integer  "cantidad_carga_chica",                 default: 0
    t.integer  "cantidad_carga_grande",                default: 0
    t.integer  "cantidad_cazador_ligero",              default: 0
    t.integer  "cantidad_cazador_pesado",              default: 0
    t.integer  "cantidad_crucero",                     default: 0
    t.integer  "cantidad_colonizador",                 default: 0
    t.integer  "cantidad_reciclador",                  default: 0
    t.integer  "cantidad_nave_batalla",                default: 0
    t.integer  "cantidad_sonda_espionaje",             default: 0
    t.integer  "cantidad_bombardero",                  default: 0
    t.integer  "cantidad_satelite_solar",              default: 0
    t.integer  "cantidad_destructor",                  default: 0
    t.integer  "cantidad_estrella_muerte",             default: 0
    t.integer  "cantidad_acorazado",                   default: 0
    t.integer  "cantidad_lanzamisiles",                default: 0
    t.integer  "cantidad_laser_chico",                 default: 0
    t.integer  "cantidad_laser_grande",                default: 0
    t.integer  "cantidad_canon_ionico",                default: 0
    t.integer  "cantidad_canon_gauss",                 default: 0
    t.integer  "cantidad_canon_plasma",                default: 0
    t.integer  "cantidad_cupula_chica",                default: 0
    t.integer  "cantidad_cupula_grande",               default: 0
    t.integer  "cantidad_misil_intercepcion",          default: 0
    t.integer  "cantidad_misil_interplanetario",       default: 0
    t.float    "cantidad_metal",                       default: 0.0
    t.float    "cantidad_cristal",                     default: 0.0
    t.float    "cantidad_deuterio",                    default: 0.0
    t.integer  "cantidad_campos"
    t.datetime "ultima_actualizacion_recursos"
    t.boolean  "es_principal",                         default: false
    t.integer  "universo_id"
    t.integer  "cuenta_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "planetas", ["cuenta_id"], name: "index_planetas_on_cuenta_id", using: :btree
  add_index "planetas", ["universo_id"], name: "index_planetas_on_universo_id", using: :btree

  create_table "universos", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "cantidad_planetas_por_cuenta",           default: 1
    t.integer  "cantidad_construcciones_en_simultaneo",  default: 1
    t.integer  "cantidad_investigaciones_en_simultaneo", default: 1
    t.integer  "cantidad_rondas_en_batallas",            default: 6
    t.integer  "cantidad_galaxias",                      default: 1
    t.integer  "cantidad_sistemas",                      default: 1
    t.integer  "cantidad_planetas",                      default: 1
    t.integer  "cantidad_metal_inicial",                 default: 500
    t.integer  "cantidad_cristal_inicial",               default: 500
    t.integer  "cantidad_deuterio_inicial",              default: 0
    t.integer  "puntos_protegidos",                      default: 5000
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
