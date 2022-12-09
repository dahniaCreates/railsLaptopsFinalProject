class Order < ApplicationRecord
  belongs_to :customer
  validates :order_date, :status,presence: true
end
