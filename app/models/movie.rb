class Movie < ActiveRecord::Base
  
  has_many :movie_genres
  has_many :genres, :through => :movie_genres

  has_many :ratings
  has_many :users, :through => :ratings

end
