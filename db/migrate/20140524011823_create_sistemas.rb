class CreateSistemas < ActiveRecord::Migration
  def change
    create_table :sistemas do |t|
      t.integer :coordenada

      t.references :galaxia, index: true
      t.timestamps
    end
  end
end
