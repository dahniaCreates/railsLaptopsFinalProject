class CheckoutController < ApplicationController
  def create
      @line_items_dictionary = []
      @taxes_dict = []
      @total_price = 0
      @taxes = Tax.where(province: current_user.tax.province)
      @cart.orderables.each do |orderable|
        @product = orderable.product
        @checkout_price = @product.price
        if @product.discount_price.present?
          @checkout_price = @product.discount_price
        end
        @total_price +=  (@checkout_price * 100).round()
        @line_items_dictionary << {
          price_data: {
            currency: 'cad',
            unit_amount: (@checkout_price * 100).round(),
            product_data: {
              name: @product.category.name + " " + @product.name,
              description: @product.category.name + " " + @product.name,
            },
          },
          quantity: orderable.quantity,
        }
      end
      @taxes.each do |tax|
        if tax.GST.present?
          @taxes_dict << {
            price_data: {
              currency: 'cad',
              unit_amount: (@total_price * tax.GST).to_i,
              product_data: {
                name: "GST",
                description: "Goods and Services Tax",
              },
            },
            quantity: 1,
          }
          end
        if tax.PST.present?
          @taxes_dict << {
            price_data: {
              currency: 'cad',
              unit_amount: (@total_price * tax.PST).to_i,
              product_data: {
                name: "PST",
                description: "Provincial Sales Tax",
              },
            },
            quantity: 1,
          }
        end
        if tax.HST.present?
          @taxes_dict << {
            price_data: {
              currency: 'cad',
              unit_amount: (@total_price * tax.HST).to_i,
              product_data: {
                name: "HST",
                description: "Harmonized Sales Tax",
              },
            },
            quantity: 1,
          }
        end
      end
    @session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: [@line_items_dictionary + @taxes_dict],
        mode: 'payment',
        success_url: root_url,
        cancel_url: root_url,
      })
      respond_to do |format|
        format.html
      end
  end
end