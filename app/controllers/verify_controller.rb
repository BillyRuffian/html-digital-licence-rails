class VerifyController < ApplicationController
  layout 'webapp'
  protect_from_forgery except: [:create]

  def new
  end

  def create
  end
end
