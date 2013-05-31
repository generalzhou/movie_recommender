class CreateFavoriteGenre < ActiveRecord::Migration
  def change
    create_table :favorite_genres do |t|
      t.references :user
      t.references :genre
    end
  end
end
