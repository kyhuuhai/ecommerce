class Product < ApplicationRecord
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :cart_details, dependent: :destroy
  has_many :pictures, as: :imageable

  enum status: {available: 0, not_exist: 1}

  accepts_nested_attributes_for :pictures, allow_destroy: true

  scope :search_by_name, ->term{where('LOWER(name) LIKE ?', "%#{term.downcase}%")}
  scope :not_in, ->ids { where.not id: ids }
  scope :by_ids, ->ids {where id: ids}

  def category_name
    category.try(:name)
  end

  def category_name=(name)
    self.category = Category.find_or_create_by!(name: name) if name.present?
  end

  def self.search term
    word = term.present? ? term : ""
    where('LOWER(name) LIKE :term', term: "%#{word.downcase}%")
  end
end
