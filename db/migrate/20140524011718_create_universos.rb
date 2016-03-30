class CreateUniversos < ActiveRecord::Migration
  def change
    create_table :universos do |t|
      t.string :nombre
      t.integer :cantidad_planetas_por_cuenta, default: 1
      t.integer :cantidad_construcciones_en_simultaneo, default: 1
      t.integer :cantidad_investigaciones_en_simultaneo, default: 1

      t.integer :cantidad_rondas_en_batallas, default: 6

      t.integer :cantidad_galaxias, :cantidad_sistemas, :cantidad_planetas, default: 1

      t.integer :cantidad_metal_inicial, default: 500
      t.integer :cantidad_cristal_inicial, default: 500
      t.integer :cantidad_deuterio_inicial, default: 0

      t.integer :puntos_protegidos, default: 5000

      t.timestamps
    end
  end
end
