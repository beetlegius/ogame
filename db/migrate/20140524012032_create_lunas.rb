class CreateLunas < ActiveRecord::Migration
  def change
    create_table :lunas do |t|
      t.string :nombre

      t.references :planeta, index: true
      t.timestamps
    end
  end
end
