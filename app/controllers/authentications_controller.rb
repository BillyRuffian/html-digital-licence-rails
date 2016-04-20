class AuthenticationsController < ApplicationController
  protect_from_forgery except: [:check]
  layout 'webapp'

  def new
  end

  def create
    # TODO: lots and lots of validation stuff needed, obvs

    driver_number = params[:driverNumber]
    pin = params[:pin]
    pin_conf = params[:pin_confirmation]
    fingerprint = params[:fingerprint]

    user = User.find_or_create_by( driver_number: driver_number )
    user.pin = pin
    user.save
    device = user.devices.find_or_create_by( fingerprint: fingerprint )
    device.save
    @token = verifier.generate( driver_number )
  end

  def check
    # TODO: ...and we need to revalidate our assertions here

    driver_number = params[:driverNumber]
    fingerprint = params[:fingerprint]

    pin = params[:pin]
    user = nil
    if pin && driver_number
      user = User.find_by_driver_number_and_pin( driver_number, pin)
    end

    if user
      user.devices.find_or_create_by( fingerprint: fingerprint )
      redirect_to webapps_path
    else
      flash[:notice] = 'Wrong PIN'
      render 'pin_check'
    end
  end
end
