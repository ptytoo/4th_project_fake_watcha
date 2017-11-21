require 'httparty'
require 'rest-client'
require 'json'
require 'awesome_print'

headers = {
  cookie: "__uvt=; _s_guit=f10c8e91c0503c38f9ea52dfc9d6deae0e88dbbfe84578d18576f9a59bcf; _ga=GA1.2.2022268110.1510124137; _gid=GA1.2.612693856.1511237787; uvts=6m4W3ve1M6anT2hF; _guinness_session=VlhGb1RhRitKOG1GSk9Vd2tkRXpsTi9DbHhiZ05lcmowZm80M01pcEtCdDlPM3Y5d0V5bGd5UFpUTjFsejc2dUFFaWtuSjJyUHFGa1gxcFhaQjdQb3I0SDhEM3dtSkRzZG5OdVRQaDZXMWc2eFc1blpsYWlUTGtTbEsvZkFpQ0VXeEpUeGZaL1dtTDc0MExHZkg5WUNRRzBsVFEyc2RGR1lwMC9tMTBLQTNFMlFUM1J0UUNGZzE4Qk96cHNhVmNUYW1xblA3MGdpT3dPOWJwelRMVGJqUm9FRWxjcHc1ZmdUVExicGJMY2Y0TmdRRllKb2lmZnViellZc2psZ0hGVy0tK2RlSE0wbHIxTzRZWkZEMVY4WFFVdz09--99946ee1c35879b2ec22746c89aec0b5eaced023"
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
