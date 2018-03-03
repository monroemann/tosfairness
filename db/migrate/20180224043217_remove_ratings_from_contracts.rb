class RemoveRatingsFromContracts < ActiveRecord::Migration[5.0]
  def up
    remove_column :contracts, :contract_date
    remove_column :contracts, :rating_1
    remove_column :contracts, :rating_2
    remove_column :contracts, :rating_3
    remove_column :contracts, :rating_4
    remove_column :contracts, :rating_5
    remove_column :contracts, :rating_6
    remove_column :contracts, :rating_7
    remove_column :contracts, :rating_8
    remove_column :contracts, :rating_9
    remove_column :contracts, :rating_10
    remove_column :contracts, :rating_11
    remove_column :contracts, :rating_12
    remove_column :contracts, :rating_13
    remove_column :contracts, :rating_14
    remove_column :contracts, :total_rating
    remove_column :contracts, :rating_1_note
    remove_column :contracts, :rating_2_note
    remove_column :contracts, :rating_3_note
    remove_column :contracts, :rating_4_note
    remove_column :contracts, :rating_5_note
    remove_column :contracts, :rating_6_note
    remove_column :contracts, :rating_7_note
    remove_column :contracts, :rating_8_note
    remove_column :contracts, :rating_9_note
    remove_column :contracts, :rating_10_note
    remove_column :contracts, :additional_note
    remove_column :contracts, :number_lawsuit
    remove_column :contracts, :lawsuit_score
  end

  def down
    add_column :contracts, :contract_date
    add_column :contracts, :rating_1
    add_column :contracts, :rating_2
    add_column :contracts, :rating_3
    add_column :contracts, :rating_4
    add_column :contracts, :rating_5
    add_column :contracts, :rating_6
    add_column :contracts, :rating_7
    add_column :contracts, :rating_8
    add_column :contracts, :rating_9
    add_column :contracts, :rating_10
    add_column :contracts, :rating_11
    add_column :contracts, :rating_12
    add_column :contracts, :rating_13
    add_column :contracts, :rating_14
    add_column :contracts, :total_rating
    add_column :contracts, :rating_1_note
    add_column :contracts, :rating_2_note
    add_column :contracts, :rating_3_note
    add_column :contracts, :rating_4_note
    add_column :contracts, :rating_5_note
    add_column :contracts, :rating_6_note
    add_column :contracts, :rating_7_note
    add_column :contracts, :rating_8_note
    add_column :contracts, :rating_9_note
    add_column :contracts, :rating_10_note
    add_column :contracts, :additional_note
    add_column :contracts, :number_lawsuit
    add_column :contracts, :lawsuit_score
  end
end
