class IpLocation < ApplicationRecord

  # Given some bounds (diagonally opposed corners of a map, specifically the SW and NE corners)
  # returns  an array of lat and long of ip addresses as well as a calculated frequency
  def self.from_bounds(bounds)
    min_latitude = bounds['south_west']['lat']
    max_latitude = bounds['north_east']['lat']
    max_longitude = bounds['north_east']['lng']
    min_longitude = bounds['south_west']['lng']

    res = IpLocation.where("latitude >= ? AND latitude <= ? AND longitude >= ? AND longitude <= ?",
                     min_latitude, max_latitude, min_longitude, max_longitude).group(:latitude, :longitude).count

    if res.length > 0
      # Get the count of the most ip addresses that share a lat / long pair
      max_count = res.max_by{|k,v| v}

      # Take the log base 100 of that highest count
      log_max_count = Math.log(max_count[1], 100)

      # Calculate the relative frequency for each lat / long pair as it compares to the log_max_count
      # This should give us some spectrum where the frequencies calculated are between 0 and 1 with 1 being the most
      # frequent lat / long pair
      res.map{|i| [i[0][0], i[0][1], (Math.log(i[1], 100) / log_max_count)]}
    else
      []
    end
  end
end