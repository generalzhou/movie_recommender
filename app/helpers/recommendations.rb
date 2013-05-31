def recommend(user1_ratings)
  total_scores = {}
  normalization_factor = {}
  user1_ratings.each do |movie, rating|
    SIMILAR_ITEMS[movie].each do |movie2, score|
      unless user1_ratings.keys.include?(movie2)
        total_scores[movie2] ||= 0
        normalization_factor[movie2] ||= 0
        total_scores[movie2] += score * rating
        normalization_factor[movie2] += score
      end

    end
  
  end

  total_scores.keys.inject({}) do |rec, movie|
    rec[movie] = total_scores[movie]/normalization_factor[movie]
    rec
  end

end

def top_matches(user1_ratings, preferences = USER_RATINGS)
  preferences.inject({}) do |matches, (user2_id, user2_ratings)|    
    if (user1_ratings.keys & user2_ratings.keys).length > 10
      pearson = pearson_correlation(user1_ratings, user2_ratings)
      matches[user2_id] = pearson unless pearson.nan?
    end
    matches
  end
end
