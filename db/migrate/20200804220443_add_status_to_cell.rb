class AddStatusToCell < ActiveRecord::Migration[5.2]
  def change
    add_column :cells, :status, :string
  end
end
