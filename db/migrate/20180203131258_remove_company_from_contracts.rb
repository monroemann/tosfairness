class RemoveCompanyFromContracts < ActiveRecord::Migration[5.0]
  def change
    remove_column :contracts, :company_name
    remove_column :contracts, :website
  end
end
