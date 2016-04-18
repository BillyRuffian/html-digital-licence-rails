class AuthenticationsController < ApplicationController

  layout 'webapp'

  def new
  end

  def create
    # lots and lots of validation stuff needed, obvs

    driver_number = params[:driverNumber]
    pin = params[:pin]
    pin_conf = params[:pin_confirmation]
    fingerprint = params[:fingerprint]

    user = User.new( driver_number: driver_number, pin: pin )
    user.save
    device = user.devices.build( fingerprint: fingerprint )
    device.save
    @token = verifier.generate( driver_number )

    redirect_to webapps_path
  end
end
