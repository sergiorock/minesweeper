class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.integer :rows
      t.integer :columns
      t.integer :mines

      t.timestamps
    end
  end
end
