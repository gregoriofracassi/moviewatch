class AddTop5ToLikes < ActiveRecord::Migration[5.2]
  def change
    add_column :likes, :top5, :boolean, default:false
  end
end
