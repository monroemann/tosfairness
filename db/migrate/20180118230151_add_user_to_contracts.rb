class AddUserToContracts < ActiveRecord::Migration[5.0]
  def change
    add_column :contracts, :user_id, :integer
    add_index  :contracts, :user_id
  end
end
