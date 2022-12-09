class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image
  validates :name, :screen, :screen_size, :cpu, :gpu, :ram, :storage, :operating_system, presence: true

  # transform shopping cart products into an array of line items
  def to_builder
    Jbuilder.new do |product|
      product.price product.stripe_price_id
      product.quantity 1
    end
  end

  paginates_per 10
end
