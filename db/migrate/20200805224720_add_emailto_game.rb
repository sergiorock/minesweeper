class AddEmailtoGame < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :email, :string
  end
end
