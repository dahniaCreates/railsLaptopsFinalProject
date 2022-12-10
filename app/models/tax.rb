class Tax < ApplicationRecord
  has_many :user

  def to_s
    self.province
  end
end
