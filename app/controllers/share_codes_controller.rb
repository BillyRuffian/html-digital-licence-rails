class ShareCodesController < ApplicationController
  layout 'webapp'
  protect_from_forgery except: [:create]

  def create
    authenticate
    @code = generate_activation_code
  end

  private

  # Generates a random string from a set of easily readable characters
  def generate_activation_code(size = 8)
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z a b c d e f g h j k m n p q r t w x y z}
    (0...size).map{ charset.to_a[rand(charset.size)] }.join
  end
end
