class ProductsController < ApplicationController
  def index
    @products = Product.all
    # started with lines 5-7 then refactored to move code into application_controller

  end

  def show
    @product = Product.find(params[:id])
  end
end
