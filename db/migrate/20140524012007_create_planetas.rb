class CreatePlanetas < ActiveRecord::Migration
  def change
    create_table :planetas do |t|
      t.string  :nombre
      t.integer :temperatura_minima, :temperatura_maxima
      # t.integer :coordenada

      t.integer :numero_galaxia
      t.integer :numero_sistema
      t.integer :numero_planeta

      t.integer :nivel_mina_metal,        default: 0
      t.integer :nivel_mina_cristal,      default: 0
      t.integer :nivel_mina_deuterio,     default: 0
      t.integer :nivel_planta_energia,    default: 0
      t.integer :nivel_planta_fusion,     default: 0
      t.integer :nivel_fabrica_robots,    default: 0
      t.integer :nivel_fabrica_nanobots,  default: 0
      t.integer :nivel_hangar,            default: 0
      t.integer :nivel_almacen_metal,     default: 0
      t.integer :nivel_almacen_cristal,   default: 0
      t.integer :nivel_almacen_deuterio,  default: 0
      t.integer :nivel_laboratorio,       default: 0
      t.integer :nivel_silo,              default: 0

      t.integer :porcentaje_produccion_mina_metal,     default: 100
      t.integer :porcentaje_produccion_mina_cristal,   default: 100
      t.integer :porcentaje_produccion_mina_deuterio,  default: 100
      t.integer :porcentaje_produccion_planta_energia, default: 100
      t.integer :porcentaje_produccion_planta_fusion,  default: 100

      t.float   :cantidad_metal,          default: 0
      t.float   :cantidad_cristal,        default: 0
      t.float   :cantidad_deuterio,       default: 0

      t.integer :cantidad_campos

      t.datetime :ultima_actualizacion_recursos

      t.boolean :es_principal, default: false

      t.references :universo, :cuenta, index: true
      t.timestamps
    end
  end
end
