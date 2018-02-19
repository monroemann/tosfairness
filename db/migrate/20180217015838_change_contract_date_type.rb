class ChangeContractDateType < ActiveRecord::Migration[5.0]
  def up
      change_column :contracts, :contract_date, 'date USING CAST(contract_date AS date)', :null => false
  end

  def down
    change_column :contracts, :contract_date, :string
  end
end
