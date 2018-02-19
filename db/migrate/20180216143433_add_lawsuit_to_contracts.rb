class AddLawsuitToContracts < ActiveRecord::Migration[5.0]
  def up
    add_column :contracts, :number_lawsuit, :integer, default: 0
    add_column :contracts, :lawsuit_score, :integer, default: 0
  end

  def down
    remove_column :contracts, :number_lawsuit, :integer, default: nil
    remove_column :contracts, :lawsuit_score, :integer, default: nil
  end
end
