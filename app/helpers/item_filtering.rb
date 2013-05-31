def recommend_with_filtering(preferences, person1)
  filtered_items = calculate_similar_items(preferences)
  unrated_items = possible_recommendations(preferences, person1)
  result = {}
  similarity_totals = {}
  unrated_items.each do |item|
    result[item] = 0
    similarity_totals[item] = 0
  end
  
  preferences[person1].each do |rated_item, score|
    unrated_items.each do |unrated_item|
      similarity_score = filtered_items[rated_item][unrated_item]
      similarity_totals[unrated_item] += similarity_score
      result[unrated_item] += similarity_score * score
    end
  end
  result.keys.each do |unrated_item|
    puts "#{unrated_item} : #{result[unrated_item]}"
    result[unrated_item] /= similarity_totals[unrated_item] 
  end
  result
end

def calculate_similar_items(prefs)
  result = {}
  item_prefs = transform(prefs)
  item_prefs.keys.each do |item|
    scores = rank_similarity(item_prefs, item, :euclidean)
    result[item] = scores
  end
  result
end
