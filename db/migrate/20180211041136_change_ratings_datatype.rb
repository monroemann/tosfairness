class ChangeRatingsDatatype < ActiveRecord::Migration[5.0]
  def change
    change_table :contracts do |t|
      t.change :rating_11, :float
      t.change :rating_12, :float
      t.change :rating_13, :float
      t.change :rating_14, :float
    end
  end
end
