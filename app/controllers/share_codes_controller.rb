class ShareCodesController < ApplicationController
  protect_from_forgery except: [:create]

  def create
    authenticate
  end


  def register_user( driver_number )
    raise "NoDriverNumberProvided" if driver_number.blank?
  end

end
