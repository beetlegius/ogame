class CreateCuerposCelestes < ActiveRecord::Migration
  def change
    create_table :cuerpos_celestes do |t|
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

      t.integer :cantidad_carga_chica,        default: 0
      t.integer :cantidad_carga_grande,       default: 0
      t.integer :cantidad_cazador_ligero,     default: 0
      t.integer :cantidad_cazador_pesado,     default: 0
      t.integer :cantidad_crucero,            default: 0
      t.integer :cantidad_colonizador,        default: 0
      t.integer :cantidad_reciclador,         default: 0
      t.integer :cantidad_nave_batalla,       default: 0
      t.integer :cantidad_sonda_espionaje,    default: 0
      t.integer :cantidad_bombardero,         default: 0
      t.integer :cantidad_satelite_solar,     default: 0
      t.integer :cantidad_destructor,         default: 0
      t.integer :cantidad_estrella_muerte,    default: 0
      t.integer :cantidad_acorazado,          default: 0

      t.integer :cantidad_lanzamisiles,          default: 0
      t.integer :cantidad_laser_chico,           default: 0
      t.integer :cantidad_laser_grande,          default: 0
      t.integer :cantidad_canon_ionico,          default: 0
      t.integer :cantidad_canon_gauss,           default: 0
      t.integer :cantidad_canon_plasma,          default: 0
      t.integer :cantidad_cupula_chica,          default: 0
      t.integer :cantidad_cupula_grande,         default: 0
      t.integer :cantidad_misil_intercepcion,    default: 0
      t.integer :cantidad_misil_interplanetario, default: 0

      t.float   :cantidad_metal,          default: 0
      t.float   :cantidad_cristal,        default: 0
      t.float   :cantidad_deuterio,       default: 0

      t.integer :cantidad_campos

      t.datetime :ultima_actualizacion_recursos

      t.boolean :es_principal, default: false

      t.string :type
      t.references :universo, :cuenta, :planeta, index: true
      t.timestamps
    end
  end
end
