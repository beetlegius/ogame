class CreatePlanetas < ActiveRecord::Migration
  def change
    create_table :planetas do |t|
      t.string :nombre
      t.integer :temperatura_minima, :temperatura_maxima
      t.integer :coordenada

      t.float :cantidad_metal, default: 0
      t.float :cantidad_cristal, default: 0
      t.float :cantidad_deuterio, default: 0

      t.integer :cantidad_campos

      t.datetime :ultima_actualizacion_recursos

      t.boolean :es_principal, default: false

      t.references :sistema, :cuenta, index: true
      t.timestamps
    end
  end
end
