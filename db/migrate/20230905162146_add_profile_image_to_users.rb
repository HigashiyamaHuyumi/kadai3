class AddProfileImageToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :profile_image, :image
  end
end
