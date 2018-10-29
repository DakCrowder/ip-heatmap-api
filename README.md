# Backend for the ipv6 heatmap
An api with one endpoint and a few tests

## The Endpoint
api/ip_locations

Endpoint accepts a square bounding area made up of lat/long pairs
The pairs should be provided in an object like the following:
```clickhouse
{north_east: {lat: 90 , lng: 180}, south_west: {lat: -70, lng: -180}}
```
north_east and south_west should map to the top right and bottom left corners
of the bounding area


## Running Locally
If you were so inclined to run this locally you would need to get ruby 2.5.1

Get the server running (port 3000 by default)
```clickhouse
rails server
``` 

You would also need to seed the DB to get anything from the endpoint :)
```clickhouse
rake db:seed
``` 

Running tests
```clickhouse
rake test
```



