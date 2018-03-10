class AddTosUrlToContractRevisions < ActiveRecord::Migration[5.0]
  def up
    add_column :contract_revisions, :lawsuit_note, :text
    add_column :contract_revisions, :tos_url, :string
  end

  def down
    remove_column :contract_revisions, :lawsuit_note
    remove_column :contract_revisions, :tos_url
  end
end
