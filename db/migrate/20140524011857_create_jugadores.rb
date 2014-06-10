class CreateJugadores < ActiveRecord::Migration
  def change
    create_table :jugadores do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
