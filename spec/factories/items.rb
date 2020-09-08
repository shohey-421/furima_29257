FactoryBot.define do
  factory :item do
    name { Faker::Book.title }
    description { Faker::Lorem.sentence }
    category_id { Faker::Number.between(from: 1, to: 10) }
    condition_id { Faker::Number.between(from: 1, to:6) }
    shipping_burden_id { Faker::Number.between(from: 1, to: 2) }
    ship_from_id { Faker::Number.between(from: 1, to: 47) }
    shipping_date_id { Faker::Number.between(from: 1, to: 3) }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user
  end
end
