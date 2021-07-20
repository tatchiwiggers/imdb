require 'nokogiri'
require 'open-uri'

def fetch_movie_urls
  top_url = 'https://www.imdb.com/chart/top'
  doc = Nokogiri::HTML(open(top_url).read)

  movies = doc.search('.titleColumn a')
  movies.take(5).map do |movie|
    uri = URI.parse(movie.attributes['href'].value)
    uri.scheme = 'https'
    uri.host ='www.imdb.com'
    uri.to_s
  end
end

# fetch_movie_urls

def scrape_movies(url)
  doc = Nokogiri::HTML(open(url).read)

  title = doc.search('h1').text
  year = doc.search('.TitleBlockMetaData__ListItemText-sc-12ein40-2').first.text
  storyline = doc.search('.GenresAndPlot__Plot-cum89p-6 span').first.text
  director = doc.search('.ipc-metadata-list__item:contains("Director") a').first.text
  cast = doc.search('.ipc-metadata-list__item:contains("Stars") a.ipc-metadata-list-item__list-content-item').map { |element| element.text}.uniq

  {
    title: title,
    year: year,
    storyline: storyline,
    director: director,
    cast: cast
  }

end

# puts scrape_movies('https://www.imdb.com/title/tt0111161/')
