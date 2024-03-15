class CartController < ApplicationController
  def create
    logger.debug("adding #{params[:id]} to cart.")
    id = params[:id].to_i
    session[:shopping_cart] << id unless session[:shopping_cart].include?(id)
    product = Product.find(id)
    flash[:notice] = "✚ #{product.name} added to cart."
    redirect_to root_path
  end
  def destroy

  end
end
