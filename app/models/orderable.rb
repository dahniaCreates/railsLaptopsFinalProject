class Orderable < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def total
    if product.discount_price.present?
      product.discount_price * quantity
    else
      product.price * quantity
    end
  end
end
