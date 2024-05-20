class AddAverageRatingInMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :avg_rating, :decimal, precision: 16, scale: 2, default: 0.0
  end
end
