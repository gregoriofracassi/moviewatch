class RemoveTop5FromMovies < ActiveRecord::Migration[5.2]
  def change
    remove_column :movies, :top5
  end
end
