FactoryBot.define do
  factory :order_address do
    token        {Faker::Lorem.characters(number: 30)}
    postcode     { "123-4567" }
    region_id    {Faker::Number.between(from: 1, to: 10)}
    city         {Faker::Address.city}
    block        {Faker::Address.street_address}
    phone_number {Faker::Number.between(from: 1, to: 99999999999)}
  end
end
