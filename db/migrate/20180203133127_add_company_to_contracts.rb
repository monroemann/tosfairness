class AddCompanyToContracts < ActiveRecord::Migration[5.0]
  def change
    add_column :contracts, :company_id, :integer
    add_index  :contracts, :company_id
  end
end
