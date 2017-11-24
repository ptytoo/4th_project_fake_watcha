require 'httparty'
require 'rest-client'
require 'json'
require 'awesome_print'

headers = {
  cookie: "put your cookie here"
}
res = HTTParty.get(
  "https://watcha.net/boxoffice.json",
  headers: headers
)
watcha = JSON.parse(res.body)

#ap watcha["cards"][0].keys
list = watcha["cards"]
CSV.open("movie_list.csv", "wb") do |csv|
  list.each do |item|
    movie = item["items"][0]["item"]
    title = movie["title"]
    desc = movie["interesting_comment"]["text"] if movie["interesting_comment"]
    image = movie["poster"]["original"]

    csv << [title, desc, image]
  end
end

# list = watcha["cards"]
# ap list.class
