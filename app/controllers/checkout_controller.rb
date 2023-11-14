class CheckoutController < ApplicationController
  def create
    # Establish the connection with Stripe and redirect the user to the payment screen
    @product = Product.find(params[:product_id])

    if @product.nil?
      redirect_to root_path
      return
    end

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url,
      line_items: [
        {
          name: @product.name,
          description: @product.description,
          amount: @product.price_cents,
          currency: 'cad',
          quantity: 1
        },
        {
          name: 'GST',
          description: 'Goods and Services Tax',
          amount: (@product.price_cents * 0.05).to_i,
          currency: 'cad',
          quantity: 1
        }
      ]
    )
    redirect_to @session.url, allow_other_host: true
  end

  def success
    # we took your money.
    @session = Stripe::Checkout::Sesssion.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end

  def cancel
    # find a better way to sell our products
  end
end
