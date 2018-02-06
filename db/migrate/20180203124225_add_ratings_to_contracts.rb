class AddRatingsToContracts < ActiveRecord::Migration[5.0]
  def change
    add_column :contracts, :rating_11, :integer
    add_column :contracts, :rating_12, :integer
    add_column :contracts, :rating_13, :integer
    add_column :contracts, :rating_14, :integer
    add_column :contracts, :rating_15, :integer
    add_column :contracts, :contract_type, :string
  end
end
