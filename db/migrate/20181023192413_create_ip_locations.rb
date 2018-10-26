class CreateIpLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :ip_locations do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
    end
  end
end
