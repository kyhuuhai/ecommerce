class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :pictures, as: :imageable
  scope :search_by_name, ->term {where('LOWER(name) LIKE ?', "%#{term.downcase}%")}

  validates :name, presence: true, uniqueness: :true, length: {maximum: 50}

  scope :newest, ->{order created_at: :desc}

  def self.search term
    where('LOWER(name) LIKE :term', term: "%#{term.downcase}%")
  end

end
