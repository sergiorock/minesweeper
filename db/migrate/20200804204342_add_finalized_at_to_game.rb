class AddFinalizedAtToGame < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :finalized_at, :datetime
  end
end
