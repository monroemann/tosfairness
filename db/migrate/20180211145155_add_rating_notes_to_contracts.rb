class AddRatingNotesToContracts < ActiveRecord::Migration[5.0]
  def up
    add_column :contracts, :rating_1_note, :text
    add_column :contracts, :rating_2_note, :text
    add_column :contracts, :rating_3_note, :text
    add_column :contracts, :rating_4_note, :text
    add_column :contracts, :rating_5_note, :text
  end

  def down
    remove_column :contracts, :rating_1_note
    remove_column :contracts, :rating_2_note
    remove_column :contracts, :rating_3_note
    remove_column :contracts, :rating_4_note
    remove_column :contracts, :ratine_4_note
  end
end
