class WebappsController < ApplicationController
  layout :determine_layout

  def show
    # is the user running on a mobile device?
    # if not show them a Govuk page
    if ! ios?
      render :show_use_mobile
    end
  end

  private

  def determine_layout
    ios? ? 'webapp' : 'application'
  end

  def ios?
    puts request.headers['User-Agent']
    /(iPhone)|(iPad)|(iPod)/ =~ request.headers['User-Agent']
  end

end
