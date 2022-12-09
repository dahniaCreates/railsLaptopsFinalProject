class Customer < ApplicationRecord
  has_many :orders, dependent: :destroy

  validates :first_name, :last_name, :province, :country, :email, :password, presence: true
end
