class ChangeNumberLawsuitsType < ActiveRecord::Migration[5.0]
  def up
    change_column :contracts, :number_lawsuit, :string
  end

  def down
    change_column :contracts, :number_lawsuit, :integer
  end
end
