class AddCommentToUserRatings < ActiveRecord::Migration[5.0]
  def up
    add_column :contract_user_ratings, :comment, :text
  end

  def down
    remove_column :contract_user_ratings, :comment
  end
end
