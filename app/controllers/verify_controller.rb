class VerifyController < ApplicationController
  layout 'webapp'
  
  before_filter {@back_to = webapps_path}
  
  def show
  end
end
