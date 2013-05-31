get '/movie/:id' do
  if_movie(params[:id]) do |movie|
    @movie = movie
    erb :movie_info_page
  end
end
