def euclidean_distance(preferences, person1, person2)
  squared_distance = 0
  preferences[person1].each do |movie, rating|
    if preferences[person2][movie]
      squared_distance += (preferences[person2][movie] - preferences[person1][movie])** 2
    end
  end
  1/( Math.sqrt(squared_distance) + 1 )
end
