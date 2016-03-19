class CreateCuentas < ActiveRecord::Migration
  def change
    create_table :cuentas do |t|
    	t.date :fecha_registro

      t.integer :nivel_tecnologia_blindaje,                 default: 0
      t.integer :nivel_tecnologia_combustion,               default: 0
      t.integer :nivel_tecnologia_computacion,              default: 0
      t.integer :nivel_tecnologia_defensa,                  default: 0
      t.integer :nivel_tecnologia_energia,                  default: 0
      t.integer :nivel_tecnologia_espionaje,                default: 0
      t.integer :nivel_tecnologia_graviton,                 default: 0
      t.integer :nivel_tecnologia_hiperespacio,             default: 0
      t.integer :nivel_tecnologia_impulso,                  default: 0
      t.integer :nivel_tecnologia_ionica,                   default: 0
      t.integer :nivel_tecnologia_laser,                    default: 0
      t.integer :nivel_tecnologia_militar,                  default: 0
      t.integer :nivel_tecnologia_plasma,                   default: 0
      t.integer :nivel_tecnologia_propulsor_hiperespacial,  default: 0
      t.integer :nivel_tecnologia_red_investigacion,        default: 0


      t.references :universo, :jugador, index: true
      t.timestamps
    end
  end
end
