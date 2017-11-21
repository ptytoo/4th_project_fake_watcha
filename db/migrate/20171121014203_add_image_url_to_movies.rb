class AddImageUrlToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :image_url, :text
  end
end
