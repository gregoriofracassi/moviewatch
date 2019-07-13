class AddStarsToLikes < ActiveRecord::Migration[5.2]
  def change
    add_column :likes, :stars, :integer
  end
end
