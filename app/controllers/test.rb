post '/pearson' do
  @user1 = params[:user1].to_i
  @user2 = params[:user2].to_i 
  @correlation = pearson_correlation(USER_RATINGS[@user1], USER_RATINGS[@user2])
  @common_movies = get_common_item_ids(USER_RATINGS[@user1], USER_RATINGS[@user2]).map do |movie_id|
    Movie.find_by_id(movie_id)
  end
  erb :_pearson
end

post '/top_movie_matches' do 
  @item_id = params[:item_id].to_i
  @top_matches = top_matches(ITEM_RATINGS[@item_id], ITEM_RATINGS).sort_by { |item, score| -score }
  erb :top_movie_matches
end

post '/top_critic_matches' do
  @user1 = params[:user_id].to_i
  USER_RATINGS[@user1]
  @top_matches = top_matches(USER_RATINGS[@user1]).sort_by { |user, score| -score }
  erb :_top_matches
end
