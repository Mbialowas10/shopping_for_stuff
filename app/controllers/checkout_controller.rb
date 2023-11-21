class CheckoutController < ApplicationController
  # establish a connection with Stripe and then redirect
  # the user to the payment screen
  def create
    # load up the product the user wishes to purhases from the product model:
    @product = Product.find(params[:product_id])

    return unless @product.nil?

    redirect_to root_path
    # return
    @session = Stripe::Checkout::Session.create(
      # went to stripe api
      payment_method_types: ['card'],
      success_url: checkout_success_url,
      cancel_url: checkout_cancel_url,
      line_items: [
        {
        price_data: {
        currency: 'cad',
        product_data: {
        name: product.name,
        description: product.description
        },
        unit_amount: product.price_cents
        },
        quantity: 1
        },
        {
        price_data: {
        currency: 'cad',
        product_data: {
        name: 'GST',
        description: 'Goods and Services Tax'
        },
        unit_amount: (product.price_cents * 0.05).to_i
        },
        quantity: 1
        }
        ]
    )
    # establish conn to Stripe
    respond_to do |format|
      format.js # render app/view/checkout.create.js.erb
    end
    redirect_to @session.url, allow_other_host: true
  end

  # we took the customer's money jay!
  def success; end

  # something went wrong with payment :(
  def cancel; end
end
