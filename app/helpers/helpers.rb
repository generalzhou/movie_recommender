def if_movie(movie_id)
  movie = Movie.find_by_id(id)
  if movie
    yield movie
  else
    erb :fail
  end
end

