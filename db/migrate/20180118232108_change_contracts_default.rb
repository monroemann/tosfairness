class ChangeContractsDefault < ActiveRecord::Migration[5.0]
  def up
    change_column :contracts, :rating_1, :integer, default: 0
    change_column :contracts, :rating_2, :integer, default: 0
    change_column :contracts, :rating_3, :integer, default: 0
    change_column :contracts, :rating_4, :integer, default: 0
    change_column :contracts, :rating_5, :integer, default: 0
    change_column :contracts, :rating_6, :integer, default: 0
    change_column :contracts, :rating_7, :integer, default: 0
    change_column :contracts, :rating_8, :integer, default: 0
    change_column :contracts, :rating_9, :integer, default: 0
    change_column :contracts, :rating_10, :integer, default: 0
    change_column :contracts, :total_rating, :integer, default: 0
  end

  def down
    change_column :contracts, :rating_1, :integer, default: nil
    change_column :contracts, :rating_2, :integer, default: nil
    change_column :contracts, :rating_3, :integer, default: nil
    change_column :contracts, :rating_4, :integer, default: nil
    change_column :contracts, :rating_5, :integer, default: nil
    change_column :contracts, :rating_6, :integer, default: nil
    change_column :contracts, :rating_7, :integer, default: nil
    change_column :contracts, :rating_8, :integer, default: nil
    change_column :contracts, :rating_9, :integer, default: nil
    change_column :contracts, :rating_10, :integer, default: nil
    change_column :contracts, :total_rating, :integer, default: nil
  end
end
