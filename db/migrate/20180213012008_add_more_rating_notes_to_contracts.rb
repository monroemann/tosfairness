class AddMoreRatingNotesToContracts < ActiveRecord::Migration[5.0]
  def up
    add_column :contracts, :rating_6_note, :text
    add_column :contracts, :rating_7_note, :text
    add_column :contracts, :rating_8_note, :text
    add_column :contracts, :rating_9_note, :text
    add_column :contracts, :rating_10_note, :text
  end

  def down
    remove_column :contracts, :rating_6_note
    remove_column :contracts, :rating_7_note
    remove_column :contracts, :rating_8_note
    remove_column :contracts, :rating_9_note
    remove_column :contracts, :ratine_10_note
  end
end
