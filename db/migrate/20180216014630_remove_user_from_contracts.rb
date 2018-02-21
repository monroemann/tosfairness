class RemoveUserFromContracts < ActiveRecord::Migration[5.0]
  def change
    remove_column :contracts, :user_id
  end
end
