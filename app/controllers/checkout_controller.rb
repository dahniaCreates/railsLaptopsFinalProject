class CheckoutController < ApplicationController
  def create
    product = Product.find(params[:id])
    @session = Stripe::Checkout::Session.create({
      mode: 'payment',
      # Remove the payment_method_types parameter
      # to manage payment methods in the Dashboard
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
        # The currency parameter determines which
        # payment methods are used in the Checkout Session.
          currency: 'cad',
            product_data: {
              name: product.name,
            },
            unit_amount: (product.price * 100).round()
          },
          quantity: 1,
        }],
        success_url: root_url,
        cancel_url: root_url,
      })
      respond_to do |format|
        format.html
      end
  end
end