def pearson_correlation(user1, user2, movie_samples = 10)
  common_items = get_common_items(user1, user2, movie_samples)
  n = common_items.length
  return 0  if n == 0

  sum1 = sum_of_scores(user1, common_items)
  sum2 = sum_of_scores(user2, common_items)

  sum_squared1 = sum_of_squares(user1, common_items)
  sum_squared2 = sum_of_squares(user2, common_items)

  sum_products = sum_of_products(user1, user2, common_items)

  numerator = sum_products - (sum1 * sum2) / n
  denominator = Math.sqrt((sum_squared1 - (sum1 ** 2)/n)*(sum_squared2 - (sum2 ** 2)/n))
  
  return numerator/denominator.to_f
end

def get_common_items(user1, user2, samples = PEARSON_SAMPLES)
  (user1.movies & user2.movies).sample(samples) #make this faster?
end

def sum_of_scores(user, common_items)
  user.ratings.where(:movie_id => common_items).inject(0) { |sum, rating| rating.value + sum }
end

def sum_of_squares(user, common_items)
  user.ratings.where(:movie_id => common_items).inject(0) { |sum, rating| rating.value**2 + sum }
end

def sum_of_products(user1, user2, common_items)
  common_items.inject(0) do |sum,item| 
    rating1 = user1.ratings.where(:movie_id => item).first.value
    rating2 = user2.ratings.where(:movie_id => item).first.value
    sum + rating1 * rating2
  end
end
