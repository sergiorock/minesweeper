class CreateCells < ActiveRecord::Migration[5.2]
  def change
    create_table :cells do |t|
      t.integer :x
      t.integer :y
      t.string :valor
      t.boolean :is_revealed
      t.references :game, foreign_key: true

      t.timestamps
    end
  end
end
