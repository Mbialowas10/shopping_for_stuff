class ApplicationController < ActionController::Base
  before_action :initialize_session
  helper_method :cart

  private

  def initialize_session
    # this will initialize the visit count to zero for new users.
    # default value when the thing on the left hand side is UNSET, when nil set to 0
    session[:shopping_cart] ||= [] # empty array of product IDs
  end

  def cart
    Product.find(session[:shopping_cart])
  end
end
