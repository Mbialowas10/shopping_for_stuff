class ApplicationController < ActionController::Base

  before_action :initialize_session
  helper_method :cart

  private
  def initialize_session
    session[:shopping_cart] ||= [] # represent an empty array of product ids
  end

  def cart
    Product.find(session[:shopping_cart]) # pass an array of products ids  get a collection of products back
  end


end
