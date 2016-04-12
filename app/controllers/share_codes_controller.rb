class ShareCodesController < ApplicationController
  protect_from_forgery except: [:create]

  def create
    puts params
    redirect_to webapps_path
  end

end
