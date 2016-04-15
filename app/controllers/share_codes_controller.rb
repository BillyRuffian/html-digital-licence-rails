class ShareCodesController < ApplicationController

  protect_from_forgery except: [:create]

  layout 'webapp'
  
  before_filter {@back_to = webapps_path}

  def create
    if !user_is_authenticated
      render :ready_user_for_verify
    end
  end
  
  private
  
  def user_is_authenticated
    false
  end

end
