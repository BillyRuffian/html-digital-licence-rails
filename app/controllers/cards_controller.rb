class CardsController < ApplicationController
  layout :determine_layout

  def show
    # is the user running on a mobile device?
    # if not show them a Govuk page
    if ! ios?
      render 'webapps/show_use_mobile'
    end
  end

  private

  def determine_layout
    ios? ? 'card' : 'application'
  end

  def ios?
    /(iPhone)|(iPad)|(iPod)/ =~ request.headers['User-Agent']
  end
end
