class ChangeRatingsDefaults < ActiveRecord::Migration[5.0]
  def up
    change_column :contracts, :rating_11, :integer, default: 0
    change_column :contracts, :rating_12, :integer, default: 0
    change_column :contracts, :rating_13, :integer, default: 0
    change_column :contracts, :rating_14, :integer, default: 0
    change_column :contracts, :rating_15, :integer, default: 0
  end

  def down
    change_column :contracts, :rating_11, :integer, default: nil
    change_column :contracts, :rating_12, :integer, default: nil
    change_column :contracts, :rating_13, :integer, default: nil
    change_column :contracts, :rating_14, :integer, default: nil
    change_column :contracts, :rating_15, :integer, default: nil
  end
end
