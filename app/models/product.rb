class Product < ApplicationRecord
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :cart_details, dependent: :destroy
  has_many :pictures, as: :imageable

  enum status: {available: 0, not_exist: 1}

  accepts_nested_attributes_for :pictures, allow_destroy: true

  def category_name
    category.try(:name)
  end

  def category_name=(name)
    self.category = Category.find_or_create_by!(name: name) if name.present?
  end
end
