class CreateContracts < ActiveRecord::Migration[5.0]
  def change
    create_table :contracts do |t|

      t.string :company_name
      t.string :website
      t.string :contract_title
      t.string :contract_date
      t.integer :rating_1
      t.integer :rating_2
      t.integer :rating_3
      t.integer :rating_4
      t.integer :rating_5
      t.integer :rating_6
      t.integer :rating_7
      t.integer :rating_8
      t.integer :rating_9
      t.integer :rating_10
      t.integer :total_rating
      t.text :description



      t.timestamps
    end
  end
end
