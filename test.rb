require 'csv'

CSV.foreach(Rails.root.join('movie_list.csv')) do |row|
  p row[title]
end
