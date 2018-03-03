class ChangeContractToUserLoggings < ActiveRecord::Migration[5.0]
  def up
    rename_column :user_loggings, :contract_id, :contract_revision_id
  end

  def down
    rename_column :user_loggings, :contract_revision_id, :contract_id
  end
end
