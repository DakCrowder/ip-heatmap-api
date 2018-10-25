class AddFieldsToIpAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :ip_locations, :address, :string
    add_column :ip_locations, :latitude, :float
    add_column :ip_locations, :longitude, :float
  end
end
