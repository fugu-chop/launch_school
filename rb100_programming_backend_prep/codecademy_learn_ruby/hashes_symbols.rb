# Hashes can be defined in a number of ways
# Defining an empty hash with a default value of 0 for non-existent keys
my_hash = Hash.new(0)

# When defining keys, we can use symbols instead of quotation marks when defining keys.
# Symbols are immutable and only one can exist at one time. 
menagerie = { 
  :foxes => 2,
  :giraffe => 1,
  :weezards => 17,
  :elves => 1,
  :canaries => 4,
  :ham => 1
}

# We can convert strings to symbols and vice versa
puts :sample.to_s
puts "string".to_sym
puts "temper".intern

# The syntax for creating a hash is now different in Ruby 1.9
new_hash = { 
  one: 1,
  two: 2,
  three: 3
}

# Filtering hashes, returning just keys or values
movie_ratings = {
  memento: 3,
  primer: 3.5,
  the_matrix: 5,
  truman_show: 4,
  red_dawn: 1.5,
  skyfall: 4,
  alex_cross: 2,
  uhf: 1,
  lion_king: 3.5
}

puts good_movies = movie_ratings.select { |movie, score| score > 3 }
puts movie_ratings.each_key { |title| puts "#{title}" } 
puts movie_ratings.each_value { |score| puts "#{score}" } 

# Gnarly conditional logic for hashes
movies = { et: 4 }

puts "Type an input, peasant! "
choice = gets.chomp.downcase

case choice
  when "add"
    puts "Please enter a movie title "
    title = gets.chomp.downcase
    puts "Please enter a movie rating "
    rating = gets.chomp.to_i
    if movies[title.to_sym].nil?
      movies[title.to_sym] = rating
      puts "Movie added!"
    else
      puts "The movie already exists!"
    end
  when "update"
    puts "Please enter a movie to update the score "
    title = gets.chomp.downcase
    if movies[title.to_sym].nil?
      puts "That movie isn't in the database"
    else
      puts "Input a new rating"
      rating = gets.chomp.to_i
      movies[title.to_sym] = rating
      puts "Rating updated!"
    end
  when "display"
    puts "Movie: Score"
    movies.each { |movie, score| puts "#{movie}: #{score}"}
  when "delete"
    puts "Please specify a movie to delete"
    title = gets.chomp.downcase
    if movies[title.to_sym].nil?
      puts "That movie isn't in the database"
    else
      movies.delete(title.to_sym)
      puts "Movie deleted"
    end
  else
    puts "I don't understand the command you've entered"
end
