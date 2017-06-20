class Category < ApplicationRecord
  has_many: products, dependent: :destroy
  has_many: pictures, as: :imageable
end
