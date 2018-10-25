class CreateIpLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :ip_locations do |t|
      t.address
      t.latitude
      t.longitude
      t.timestamps
    end
  end
end
