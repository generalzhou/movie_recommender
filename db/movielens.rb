def load_titles(file_path)
  movies = {}
  File.open(file_path, :encoding => 'ISO-8859-1').each_line do |line|
    line_data = line.split("|")
    id = line_data[0]
    title = line_data[1].gsub(/ \(\d+\)/, '') # removes the year (YYYY)
    movies[id] = title
  end
  movies
end

def load_ratings(file_path, titles)
  ratings = {}
  File.open(file_path, :encoding => 'ISO-8859-1').each_line do |line|
    line_data = line.split(" ")
    user_id = line_data[0]
    movie_title = titles[line_data[1]]
    score = (line_data[2] + '.0').to_f
    ratings[user_id] = {} unless ratings[user_id]
    ratings[user_id][movie_title] = score
  end
  ratings
end

def load_ratings_with_titles(folder_path) #assumes u.data and u.item convention
  load_ratings(folder_path + '/u.data', load_titles(folder_path + '/u.item'))
end
