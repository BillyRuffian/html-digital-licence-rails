class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def authenticate
    driver_number = params[:driverNumber]
    device_fingerprint = params[:fingerprint]

    user = User.find_by_driver_number( driver_number ) unless driver_number.blank?

    if !user.blank? && !device_fingerprint.blank?
      puts '*** known user'
      device = user.devices.find_by_fingerprint(device_fingerprint)
      if !device.blank?
        puts '*** known device'
      else
        puts '*** UNKNOWN device'
      end
    else
      # unknown user
      redirect_to new_authentications_path
    end
  end

  def verifier
    return @verifier ||= ActiveSupport::MessageVerifier.new( Rails.application.config.webapps[:secret])
  end

end
