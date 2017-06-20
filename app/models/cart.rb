class Cart < ApplicationRecord
  belongs_to :user
  has_many :cartdetails, dependent: :destroy
end
