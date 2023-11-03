class CheckoutController < ApplicationController
  # POST /checkout/create
  # a product id will be in the params hash params[:product_id]
  def create
    # Load up the product the user wishes to purchase from the product model:

    product = Product.find(params[:product_id])

    # DONT EVEN BOTHER CONTINUING IF SOMEONE IS MESSING WITH US
    if product.nil?
      redirect_to root_path
      return
    end

    # Establish a connection with Stripe and then redirect the user to the payment screen.

    # this call here, will have our server connect to stripe!
    # strip gem access to private key to setup the session behind the scenes
    # one of th bits of info is the INTERNAL ID for the session
    # so after this we need to provide that ID back to stripe for authentication.
    # That step happens in the JAVASCRIPT
    @session = Stripe::Checkout::Session.create(
      # went to stripe API, looked up sessions, figured it all out..
      payment_method_types: ['card'],
      success_url: checkout_success_url,
      cancel_url: checkout_cancel_url,
      line_items: [
        {
          name: product.name,
          description: product.description,
          amount: product.price_cents,
          currency: 'cad',
          quantity: 1 # We will hardcode one for this demo.
        },
        {
          name: 'GST',
          description: 'Goods and Services Tax',
          amount: (product.price_cents * 0.05).to_i,
          currency: 'cad',
          quantity: 1
        }
      ]
    )

    # BEFORE this, you will probably have wanted to LOOP over all line items to create and array of these items.
    # we're sticking to just ONE item for the demo.
    # would also have to loop through all taxes for that province and add it as a line item as well!
    # might be better ways with stripe API to add taxes! So go look on your own!

    # Then redirect the user to the payment screen.
    # ruby inside of the javascript!...
    # executed on server to input data into the JS before the client receives it!
    # respond_to do |format|
    # 	format.js #render app/views/checkout/create.js.erb
    # end
    redirect_to @session.url, allow_other_host: true
  end

  def success
    # We took the customer's money!
  end

  def cancel
    # Something went wrong with the payment :(
  end
end
