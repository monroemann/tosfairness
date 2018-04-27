class CreateContractRevisions < ActiveRecord::Migration[5.0]
  def change
    create_table :contract_revisions do |t|
      t.integer :contract_id

      t.date :contract_date
      t.integer :rating_1, default: 0
      t.integer :rating_2, default: 0
      t.integer :rating_3, default: 0
      t.integer :rating_4, default: 0
      t.integer :rating_5, default: 0
      t.integer :rating_6, default: 0
      t.integer :rating_7, default: 0
      t.integer :rating_8, default: 0
      t.integer :rating_9, default: 0
      t.integer :rating_10, default: 0
      t.float :rating_11, default: 0.0
      t.float :rating_12, default: 0.0
      t.float :rating_13, default: 0.0
      t.float :rating_14, default: 0.0
      t.integer  :total_rating, default: 0
      t.text    :rating_1_note
      t.text    :rating_2_note
      t.text    :rating_3_note
      t.text    :rating_4_note
      t.text    :rating_5_note
      t.text    :rating_6_note
      t.text    :rating_7_note
      t.text    :rating_8_note
      t.text    :rating_9_note
      t.text    :rating_10_note
      t.text    :additional_note
      t.string   :number_lawsuit,  default: "0"
      t.integer  :lawsuit_score,   default: 0
      t.text    :ways_to_improve
      
      t.timestamps
    end
  end
end
