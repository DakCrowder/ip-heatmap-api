class IpLocation < ApplicationRecord

  # Given some bounds (diagonally opposed corners of a map, specifically the SW and NE corners)
  # returns  an array of lat and long of ip addresses as well as a calculated frequency
  def self.from_bounds(bounds)
    # lat / long bounds
    min_latitude = bounds['south_west']['lat']
    max_latitude = bounds['north_east']['lat']
    max_longitude = bounds['north_east']['lng']
    min_longitude = bounds['south_west']['lng']

    res = IpLocation.where("latitude >= ? AND latitude <= ? AND longitude >= ? AND longitude <= ?",
                     min_latitude, max_latitude, min_longitude, max_longitude).group(:latitude, :longitude).count

    max_count = res.max_by{|k,v| v}
    max_log_count = Math.log(max_count[1], 100)
    res.map{|i| [i[0][0], i[0][1], (Math.log(i[1], 100) / max_log_count)]}
  end
end