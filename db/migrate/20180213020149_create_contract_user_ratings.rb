class CreateContractUserRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :contract_user_ratings do |t|
      t.integer :contract_id
      t.integer :user_id
      t.integer :rating, default: 0

      t.timestamps
    end
  end
end
