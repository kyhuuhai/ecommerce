class Product < ApplicationRecord
  belongs_to: category
  has_many: comments, dependent: :destroy
  has_many: cartdetails, dependent: :destroy
  has_many: pictures, as: :imageable
end
