class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def authenticate
    driver_number = params[:driverNumber]
    driver_token  = params[:token]
    device_fingerprint = params[:fingerprint]

    user = User.find_by_driver_number( driver_number ) unless driver_number.blank?
    verified_token = nil

    begin
      verified_token = verifier.verify driver_token
    rescue Exception => e
      puts '*** TOKEN NOT VERIFIED'
      puts e
      redirect_to new_verify_path
      return
    end


    if !user.blank? && !device_fingerprint.blank? && driver_number == verified_token
      puts '*** known user'
      device = user.devices.find_by_fingerprint(device_fingerprint)
      if !device.blank?
        puts '*** known device'
      else
        render 'authentications/pin_check'
        return
      end
    else
      # unknown user
      redirect_to new_verify_path
      return
    end
  end

  def verifier
    return @verifier ||= ActiveSupport::MessageVerifier.new( Rails.application.config.webapps[:secret])
  end

end
