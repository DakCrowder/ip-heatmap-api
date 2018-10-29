require 'test_helper'

class IpLocationTest < ActiveSupport::TestCase
  test "from bounds" do
    IpLocation.create(address: '1.2.3.4', latitude: 0, longitude: -170)
    IpLocation.create(address: '1.2.3.4', latitude: 90, longitude: 120)
    IpLocation.create(address: '1.2.3.4', latitude: 45, longitude: 0)
    IpLocation.create(address: '1.2.3.4', latitude: 50, longitude: -6)
    IpLocation.create(address: '1.2.3.4', latitude: 53, longitude: 43.567)
    IpLocation.create(address: '1.2.3.4', latitude: 58, longitude: 0)

    bounds = {
        'south_west' => {'lat' => 0, 'lng' => -180},
        'north_east' => {'lat' => 90, 'lng' => 180}
    }
    assert_equal 6, IpLocation.from_bounds(bounds).length

    bounds = {
        'south_west' => {'lat' => 45, 'lng' => 0},
        'north_east' => {'lat' => 90, 'lng' => 180}
    }
    assert_equal 4, IpLocation.from_bounds(bounds).length

    Rails.logger.info IpLocation.from_bounds(bounds).length

    bounds = {
        'south_west' => {'lat' => 5, 'lng' => -180},
        'north_east' => {'lat' => 4, 'lng' => 180}
    }
    assert_equal 0, IpLocation.from_bounds(bounds).length
  end

  test "relative frequency from bounds" do
    100.times do
      IpLocation.create(address: '1.2.3.4', latitude: 0, longitude: 0)
    end

    10.times do
      IpLocation.create(address: '1.2.3.4', latitude: 10, longitude: 10)
    end

    IpLocation.create(address: '1.2.3.4', latitude: 20, longitude: 20)

    bounds = {
        'south_west' => {'lat' => 0, 'lng' => -180},
        'north_east' => {'lat' => 90, 'lng' => 180}
    }
    ip_data = IpLocation.from_bounds(bounds)
    assert_equal 3, ip_data.length

    largest_freq = ip_data.find { |data| data.first == 0 }
    middle_freq = ip_data.find { |data| data.first == 10 }
    smallest_freq = ip_data.find { |data| data.first == 20 }

    assert_equal 1, largest_freq[2]
    assert_equal 0.5, middle_freq[2]
    assert_equal 0.0, smallest_freq[2]
  end
end
