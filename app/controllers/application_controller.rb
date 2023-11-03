class ApplicationController < ActionController::Base
  before_action :initialize_session
  helper_method :cart

  private

  def initialize_session
    # this will initialize the visit count to 0 for new users
    session[:shopping_cart] ||= []
  end

  def cart
    # you can pass an array of ids, and you'll get back a collection
    Product.find(session[:shopping_cart])
  end
end
