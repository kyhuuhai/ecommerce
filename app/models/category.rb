class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :pictures, as: :imageable

  def self.search term
    where('LOWER(name) LIKE :term', term: "%#{term.downcase}%")
  end
end
