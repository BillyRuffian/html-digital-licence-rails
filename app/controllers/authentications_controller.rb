class AuthenticationsController < ApplicationController
  
  layout 'webapp'
  
  before_filter {@back_to = webapps_path}
  
  def new
  end

  def create
  end
end
