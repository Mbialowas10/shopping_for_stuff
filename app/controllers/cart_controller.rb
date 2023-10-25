class CartController < ApplicationController
  # POST /cart
  # Data sent as form data (params)
  def create
    # Adds params[:id] to cart
    # the logger will show in the rails server.. super useful for debugging!!
    logger.debug("Adding #{params[:id]} to cart.")
    id = params[:id].to_i
    # add product id to shopping cart if it doesn't already exist
    session[:shopping_cart] << id unless session[:shopping_cart].include?(id) # pushes id onto the end of the array
    product = Product.find(id)
    flash[:notice] = "➕ #{product.name} added to cart."
    redirect_to root_path
  end

  # DELETE /cart/:id
  def destroy
    # removes params[:id] from cart
    # removes params[:id] from cart
    id = params[:id].to_i
    session[:shopping_cart].delete(id)
    product = Product.find(id)
    flash[:notice] = "➖ #{product.name} removed from cart." # should be removed to line below
    redirect_to root_path
  end

  # def remove_from_cart
  #   product = Product.find(params[:id])
  #   logger.debug("attemting to remove #{params[:id]} from cart.")
  #   # Remove the product from the cart logic here
  #   # ...
  #   redirect_to cart_path, notice: 'Product removed from the cart successfully.'
  # end
end
