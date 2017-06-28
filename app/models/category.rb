class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :pictures, as: :imageable

  validates :name, presence: true, length: {maximum: 50}

  scope :newest, ->{order created_at: :desc}

  def self.search term
    where('LOWER(name) LIKE :term', term: "%#{term.downcase}%")
  end
end
