def pearson_correlation(user1, user2) # takes a hash representing user's prefs
  common_item_ids = get_common_item_ids(user1, user2)
  n = common_item_ids.length
  return 0  if n == 0

  sum1 = sum_of_scores(user1, common_item_ids)
  sum2 = sum_of_scores(user2, common_item_ids)

  sum_squared1 = sum_of_squares(user1, common_item_ids)
  sum_squared2 = sum_of_squares(user2, common_item_ids)

  sum_products = sum_of_products(user1, user2, common_item_ids)

  numerator = sum_products - (sum1 * sum2) / n
  denominator = Math.sqrt((sum_squared1 - (sum1 ** 2)/n)*(sum_squared2 - (sum2 ** 2)/n))
  
  return numerator/denominator.to_f
end

def get_common_item_ids(user1, user2)
  user1.keys & user2.keys
end

def sum_of_scores(user, common_item_ids)
  common_item_ids.inject(0) { |sum, item_id| user[item_id] + sum }
end

def sum_of_squares(user, common_item_ids)
  common_item_ids.inject(0) { |sum, item_id| user[item_id]**2 + sum }
end

def sum_of_products(user1, user2, common_item_ids)
  common_item_ids.inject(0) do |sum,item_id| 
    sum + user1[item_id]*user2[item_id]
  end
end
