class Order < ApplicationRecord
  belongs_to :user
  validates :order_date, :status,presence: true
end
