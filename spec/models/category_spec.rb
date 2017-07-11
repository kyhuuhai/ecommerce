require "rails_helper"

RSpec.describe Category, type: :model do
  context "associations" do
    it{is_expected.to have_many :products}
    it{is_expected.to have_many :pictures}
  end

  context "validates" do
    it{is_expected.to validate_presence_of :name}
    it{is_expected.to validate_length_of(:name).is_at_most(50)}
    it{is_expected.to validate_uniqueness_of(:name)}

    it "is valid with a valid name" do
      expect(FactoryGirl.build(:category, name: "a" * 2)).to be_valid
    end

    it "is invalid with a long name" do
      expect(FactoryGirl.build(:category, name: "a" * 51))
        .not_to be_valid
    end
  end

  context "scope" do
    let!(:category1){FactoryGirl.create :category, name: "category1", created_at: Time.now}
    let!(:category2){FactoryGirl.create :category, name: "category2", created_at: Time.now + 1.minute}
    let!(:category3){FactoryGirl.create :category, name: "category3", created_at: Time.now + 2.minutes}

    it "returns list newest category" do
      expect(Category.newest).to eq [category3, category2, category1]
    end

    it "return list category with argument name .search_by_name" do
      expect(Category.search_by_name("3")).to eq [category3]
    end

    it "return list category with argument name .search" do
      expect(Category.search("2")).to eq [category2]
    end
  end
end
