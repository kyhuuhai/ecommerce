require "rails_helper"

RSpec.describe Product, type: :model do
  context "associations" do
    it{is_expected.to belong_to :category}
    it{is_expected.to have_many :comments}
    it{is_expected.to have_many :cart_details}
    it{is_expected.to have_many :pictures}
  end

  context "scope" do
    let!(:category){FactoryGirl.create :category, name: "category1", created_at: Time.now}
    let!(:product){FactoryGirl.create :product, name: "Product 1"}

    it "return list product with argument name .search_by_name" do
      expect(Product.search_by_name "Product").to eq [product]
    end

    it "return list product with argument name .search" do
      expect(Product.search "Product").to eq [product]
    end

    it "return product not in list of ids" do
      expect(Product.not_in([1,2,3,4])).not_to include product
    end

    it "return products by list of ids" do
      expect(Product.by_ids([1,2,3,4])).to include product
    end

    it "get name of category" do
      expect(product.category_name).to eq category.name
    end

    it "return name of category" do
      expect(product.category_name=(category.name)).to eq category.name
    end
  end
end
