class ChangeContractToUserRatings < ActiveRecord::Migration[5.0]
  def up
    rename_column :contract_user_ratings, :contract_id, :contract_revision_id
  end

  def down
    rename_column :contract_user_ratings, :contract_revision_id, :contract_id
  end
end
