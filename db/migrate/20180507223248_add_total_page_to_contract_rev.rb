class AddTotalPageToContractRev < ActiveRecord::Migration[5.0]
  def up
    add_column :contract_revisions, :total_page_note, :text
    add_column :contract_revisions, :total_page, :integer
  end

  def down
    remove_column :contract_revisions, :total_page_note
    remove_column :contract_revisions, :total_page
  end
end
