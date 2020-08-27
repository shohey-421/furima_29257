FactoryBot.define do
  factory :item do
    name {Faker::Book.title}
    description {Faker::Lorem.sentence}
    category_id {Faker::Number.between(from: 1, to: 10)}
    condition_id {Faker::Number.between(from: 1, to: 10)}
    shipping_burden_id {Faker::Number.between(from: 1, to: 10)}
    ship_from_id {Faker::Number.between(from: 1, to: 10)}
    shipping_date_id  {Faker::Number.between(from: 1, to: 10)}
    price {Faker::Number.between(from: 300, to: 9999999)}
    association :user
  end
end
