class Genre < ActiveRecord::Base

  has_many :movie_genres
  has_many :movies, :through => :movie_genres

  has_many :favorite_genres
  has_many :users, :through => :favorite_genres

end
