class RemoveLikesFromComments < ActiveRecord::Migration[7.0]
  def change
    remove_column :comments, :likes
  end
end
