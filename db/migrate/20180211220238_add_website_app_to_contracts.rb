class AddWebsiteAppToContracts < ActiveRecord::Migration[5.0]
  def up
    add_column :contracts, :website, :string
    add_column :contracts, :application, :string
  end

  def down
    remove_column :contracts, :website
    remove_column :contracts, :application
  end
end
