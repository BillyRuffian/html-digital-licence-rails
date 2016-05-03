class VerifyController < ApplicationController
  layout 'webapp'
  protect_from_forgery except: [:create]

  def new
    reset_session
  end

  def create
    session[:verify_token] = 'a token from verify'
  end
end
