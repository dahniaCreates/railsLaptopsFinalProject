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
        success_url: checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
        cancel_url: checkout_cancel_url,
      })
      respond_to do |format|
        format.html
      end
  end

  def success
    if params[:session_id].present?
      @session = Stripe::Checkout::Session.retrieve(params[:session_id])
        @order = Order.find_or_create_by(order_date: Time.now(), status: @session.payment_status, user_id: current_user.id)
        @cart.orderables.each do |orderable|
          @product = orderable.product
          @checkout_price = @product.price
          if @product.discount_price.present?
            @checkout_price = @product.discount_price
          end
          ProductOrder.find_or_create_by(price: @checkout_price , quantity: orderable.quantity, order_id: @order.id, product_id: @product.id)
        end
        @find_order = Order.where(user_id: current_user.id)
        @find_products_ordered = ProductOrder.where(order_id: @find_order.ids)
        @taxes = Tax.where(province: current_user.tax.province)
    else
      redirect_to checkout_cancel_url, alert: "No information to display."
    end
  end

  def cancel
    session[:cart_id] = []
  end
end