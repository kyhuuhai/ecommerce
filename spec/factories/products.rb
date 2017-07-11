FactoryGirl.define do
  factory :product do
    name {FFaker::Name.name}
    description{Faker::Lorem.sentence}
    status {:available}
    category_id 1
  end
end
