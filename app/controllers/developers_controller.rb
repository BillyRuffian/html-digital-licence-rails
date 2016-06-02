class DevelopersController < ApplicationController
  layout 'webapp'
  protect_from_forgery except: [:reset_fingerprint]

  def reset_token
  end

  def reset_fingerprint
    driver_number = params[:driverNumber]
    fingerprint = params[:fingerprint]
    user = User.find_or_create_by( driver_number: driver_number )
    user.devices.where( fingerprint: fingerprint ).destroy_all
    redirect_to webapps_path
  end
end
