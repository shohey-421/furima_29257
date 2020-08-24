FactoryBot.define do
  factory :user do
    nickname {Faker::Name.initials(number: 2)}
    email {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 6)
    password {password}
    password_confirmation {password}
    last_name {"苗字"}
    first_name  {"名前"}
    last_name_kana {"ミョウジ"}
    first_name_kana {"ナマエ"}
    birthday {Faker::Date.birthday(min_age: 18, max_age: 65)}
  end
end