# YAML is a human-readable data-serialization language. It is commonly used for
# configuration files and in applications where data is being stored or transmitted.
# YAML targets many of the same communications applications as Extensible Markup
# Language but has a minimal syntax.

require 'yaml'
require_relative 'scraper'


puts 'fetching urls...'
# urls is an array
urls = fetch_movie_urls

movies = urls.map do |url|
  puts "scraping #{url}"
  scrape_movies(url)
end


p movies
# is an array of hashes -> each hash is a movie:
# {
# :title=>"Um Sonho de Liberdade",
# :year=>"1994",
# :storyline=>"Two imprisoned men bond over a number of years,
# finding solace and eventual redemption through acts of common decency.",
# :director=>"Frank Darabont",
# :cast=>["Tim Robbins", "Morgan Freeman", "Bob Gunton"]
# }


# i know this because it is in the document
# try it with the other formats we learned today in class!!
puts 'writing movies to yaml file...'
File.open('movies.yml', 'w') do |f|
  f.write(movies.to_yaml)
end

puts 'pheeewww, finally done!'
