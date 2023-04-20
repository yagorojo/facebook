class ChangeDefaultImgInUser < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :img, "https://facebook-rails.s3.sa-east-1.amazonaws.com/default.webp"
  end
end
