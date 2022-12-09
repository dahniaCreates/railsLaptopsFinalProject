class CheckoutController < ApplicationController
  def create
    @session = Stripe::Checkout::Session.create({
      mode: 'payment',
      # Remove the payment_method_types parameter
      # to manage payment methods in the Dashboard
      payment_method_types: ['card'],
      @cart_items = session[:cart]
      @line_items_dictionary = []
      session[:cart].each do |item|
        @product = Product.find(item["id"])
        @line_items_dictionary << {
          price_data: {
            currency: 'cad',
            unit_amount: (product.price * 100).round(),
            product_data: {
              name: product.category.name + " " + product.name,
              description: product.category.name + " " + product.name,
            },
          },
          quantity: 1,
        }
      end
        success_url: root_url,
        cancel_url: root_url,
      })
      respond_to do |format|
        format.html
      end
  end
end