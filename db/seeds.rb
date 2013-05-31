def load_genres(file_path)
  
  File.open(file_path, :encoding => 'ISO-8859-1').each_line do |line|
    name = line.split('|')[0]
    genre = Genre.create!(name: name)
  end

end

def load_titles(file_path)
  
  File.open(file_path, :encoding => 'ISO-8859-1').each_line do |line|
    line_data = line.chomp.split("|")
    params = {}
    params[:title] = line_data[1].encode('UTF-8')
    params[:release_date] = Date.parse(line_data[2].empty? ?  '01-jan-1000' : line_data[2])
    # case id: 267 where all the data is empty
    params[:url] = line_data[4]
    
    movie = Movie.new(params)

    genre_array = line_data[5..-1]

    genre_array.each_with_index do |belongs, index|
      movie.genres << Genre.find_by_id(index + 1) if belongs == '1'
      # index has to map to db id which starts at 1
    end
    movie.save!
  end
end

# def seed_users
#   943.times { User.create!(:human => false)}
# end

# def load_ratings(file_path)
  
#   File.open(file_path, :encoding => 'ISO-8859-1').each_line do |line|
#     line_data = line.split(" ")
#     params = {}
#     params[:user_id] = line_data[0]
#     params[:movie_id] = line_data[1]
#     params[:value] = (line_data[2] + '.0').to_f
  
#     Rating.create!(params)
#   end
# end

def load_all(folder_path) #assumes u.data and u.item convention
  load_genres(folder_path + '/u.genre')
  load_titles(folder_path + '/u.item')
end

def load_ratings(file_path)
  ratings = {}
  File.open(file_path, :encoding => 'ISO-8859-1').each_line do |line|
    line_data = line.split(" ")
    user_id = line_data[0].to_i
    movie_id = line_data[1].to_i
    rating = (line_data[2] + '.0').to_f
    ratings[user_id] = {} unless ratings[user_id]
    ratings[user_id][movie_id] = rating
  end
  ratings
end

def transform(preferences)
  transformed = {}
  preferences.each do |rater_id, prefs|
    prefs.each do |item_id, rating|
      transformed[item_id] = {} unless transformed[item_id]
      transformed[item_id][rater_id] = rating
    end
  end
  transformed
end


def calculate_similar_items
  similar_items = {}
  ITEM_RATINGS.each do |item, ratings|
    matches = top_matches(ratings, ITEM_RATINGS)
    matches.delete_if {|movie, rating| movie == item}
    most_relevant = get_most_relevant(matches)
    puts most_relevant.length
    similar_items[item] = most_relevant
  end
  similar_items
end

def get_most_relevant(matches)
  matches.inject({}) do |relevant_results, (item, score)|
    relevant_results[item] = score if score.abs > 0.5
    relevant_results
  end
end


# File.open(APP_ROOT.join('db', 'similar_items.rb').to_s ,'w') do |f|
#   f.write('SIMILAR_ITEMS = ' + calculate_similar_items.inspect )
# end



# File.open(APP_ROOT.join('db', 'item_ratings.rb').to_s ,'w') do |f|
#   f.write('ITEM_RATINGS = ' + transform(USER_RATINGS).inspect )
# end
# transforms {user => {movie => ratings}} to {item=>{user => ratings}}

# File.open(APP_ROOT.join('db', 'user_ratings.rb').to_s ,'w') do |f|
#   f.write('USER_RATINGS = ' + load_ratings(APP_ROOT.join('db', 'movielens-100k', 'u.data').to_s).inspect ) 
# end
# creates a hash of all the rating data

load_all(APP_ROOT.join('db', 'movielens-100k').to_s)























