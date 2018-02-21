class ChangeUsersDefault < ActiveRecord::Migration[5.0]
  def up
    change_column :users, :first_name,  :string, default: "", null: false
    change_column :users, :last_name,   :string, default: "", null: false
    change_column :users, :country,     :string, default: "", null: false
  end

  def down
    change_column :users, :first_name,  :string, default: nil
    change_column :users, :last_name,   :string, default: nil
    change_column :users, :country,     :string, default: nil
  end
end
