class AddTimeSpentToGame < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :time_spent, :string
  end
end
