class ApplicationController < ActionController::API
  def ip_locations
    bounds = JSON.parse(params[:bounds])
    Rails.logger.info bounds
    render json: IpLocation.from_bounds(bounds)
  end
end