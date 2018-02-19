class RemoveTransparencyRating < ActiveRecord::Migration[5.0]
  def up
    remove_column :contracts, :rating_15
  end

  def down
    add_column :contracts, :rating_15, :integer
  end
end
