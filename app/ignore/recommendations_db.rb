ALGORITHMS = {:pearson => :pearson_correlation, :euclidean => :euclidean_distance}

def recommend(preferences, person1, algorithm = :pearson)
  possible_recs = possible_recommendations(preferences, person1)
  multipliers = rank_similarity(preferences, person1, algorithm)
  recommendations = Hash[possible_recs.zip(Array.new(possible_recs.length) { 0 } ) ]

  possible_recs.each do |item|
    multipliers.each do |person, multiplier|
      pref = preferences[person][item] ? preferences[person][item] : 0
      # puts "critic #{person}, movie: #{item}, score: #{pref * multiplier}"
      recommendations[item] +=  pref * multiplier
    end
    recommendations[item] /= count_recommenders(preferences, item)
  end
  recommendations
end



def possible_recommendations(preferences, person)
  prefs = get_all_items(preferences).map do |item|
    item unless preferences[person].include?(item)
  end
  prefs.delete(nil)
  prefs = prefs.uniq
end

def count_recommenders(preferences, item)
  preferences.inject(0) do |count, (person, prefs)|
    prefs.include?(item) ? count + 1 : count
  end
end

def get_all_items(preferences)
  preferences.values.map {|review_set| review_set.keys }.flatten
end

def rank_similarity(user1, movie_samples=MOVIE_SAMPLES, user_samples=USER_SAMPLES)
  users = {}
  count = 0
  pearson = 0
  user1.movies.sample(movie_samples).each do |movie|
    movie.users.sample(user_samples).each do |user2|
      count += 1
      unless users[user2] || user2 == user1
        unless get_common_items(user1,user2).length < 15
          users[user2] = pearson_correlation(user1, user2)
          pearson += 1
        end
      end
    end
  end
  puts "COUNT: #{count}"
  puts "PEARSON: #{pearson}"
  users
end

def transform(preferences)
  transformed = {}
  preferences.each do |person, prefs|
    prefs.each do |item, score|
      transformed[item] = {} unless transformed[item]
      transformed[item][person] = score
    end
  end
  transformed
end
