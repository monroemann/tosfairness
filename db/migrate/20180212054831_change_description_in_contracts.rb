class ChangeDescriptionInContracts < ActiveRecord::Migration[5.0]
  def up
     rename_column :contracts, :description, :additional_note
  end
end
