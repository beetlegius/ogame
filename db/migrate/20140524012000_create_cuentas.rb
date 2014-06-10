class CreateCuentas < ActiveRecord::Migration
  def change
    create_table :cuentas do |t|
    	t.date :fecha_registro

      t.references :universo, :jugador, index: true
      t.timestamps
    end
  end
end
