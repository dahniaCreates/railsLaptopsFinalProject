class Product < ApplicationRecord
  belongs_to :category
  has_many :orderables
  has_many :carts, through: :orderables
  has_one_attached :image
  validates :name, :screen, :screen_size, :cpu, :gpu, :ram, :storage, :operating_system, presence: true

  # transform shopping cart products into an array of line items

  paginates_per 10
end
