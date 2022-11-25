class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image

  paginates_per 20
end
