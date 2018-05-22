class AddStatusToContractRevisions < ActiveRecord::Migration[5.0]
  def up
    add_column :contract_revisions, :status, :text
  end

  def down
    remove_column :contract_revisions, :status
  end
end
