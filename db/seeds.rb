# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

# csv_text = File.read(Rails.root.join('db/GeoLite2-City-Blocks-IPv6.csv'))
# csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# puts csv
#
CSV.foreach('db/GeoLite2-City-Blocks-IPv6.csv', {:headers=>:first_row}) do |row|
  ip_location = IpLocation.new
  ip_location.address = row[0]
  ip_location.latitude = row[7]
  ip_location.longitude = row[8]
  ip_location.save
end