get '/' do
  redirect '/start'
end

get '/start' do
  erb :start
end

get '/pick_genres' do
  if request.xhr?
    erb :pick_genres, :layout =>false
  else
    erb :pick_genres
  end
end

get '/pick_movies/genres' do
  @genre_ids = params.values.map { |id| id.to_i }
  erb :pick_movies
end

post '/get_recommendations' do
  user_ratings = {}
  params.each do |movie_id, rating|
    user_ratings[movie_id.to_i] = rating.to_i unless rating == "0"
  end

  session[:user_ratings] = user_ratings
  i = 1
  @recommendations = {}

  recommend(user_ratings).each do |key, value| 
    @recommendations[key] = value unless i > 15
    i += 1
  end

  erb :recommendations
end

