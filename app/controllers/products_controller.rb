class ProductsController < ApplicationController
  def index
    @products = Product.all
    # started with lines 5-7 then refactored to move code into application_controller
    # session[:visit_count] ||= 0
    # session[:visit_count] += 1
    # @visit_count = session[:visit_count]
  end

  def show
    @product = Product.find(params[:id])
  end
end
