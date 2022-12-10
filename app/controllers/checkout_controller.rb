class CheckoutController < ApplicationController
  def create
    @cart_items = session[:cart]
      @line_items_dictionary = []
      @cart_items.each do |item|
        @product = Product.find(item)
        @line_items_dictionary << {
          price_data: {
            currency: 'cad',
            unit_amount: (@product.price * 100).round(),
            product_data: {
              name: @product.category.name + " " + @product.name,
              description: @product.category.name + " " + @product.name,
            },
          },
          quantity: 1,
        }
      end
    @session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: [@line_items_dictionary],
        mode: 'payment',
        success_url: root_url,
        cancel_url: root_url,
      })
      respond_to do |format|
        format.html
      end
  end
end