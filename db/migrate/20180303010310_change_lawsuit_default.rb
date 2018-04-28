class ChangeLawsuitDefault < ActiveRecord::Migration[5.0]
  def up
    change_column :contract_revisions, :total_rating, :float, default: 0.0
    change_column :contract_revisions, :lawsuit_score, :integer, default: 10
  end

  def down
    change_column :contract_revisions, :total_rating, :integer, default: 0
    change_column :contract_revisions, :lawsuit_score, :integer, default: 0
  end
end
