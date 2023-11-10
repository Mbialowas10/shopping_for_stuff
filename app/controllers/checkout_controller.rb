class CheckoutController < ApplicationController
  def create
    # Establish the connection with Stripe and redirect the user to the payment screen
    @product = Product.find(params[:product_id])

    return unless @product.nil?

    redirect_to root_path
  end

  def success
    # we took your money.
  end

  def cancel
    # find a better way to sell our products
  end
end
