FactoryBot.define do

  factory :product do
    name                  {"hoge"}
    description           {"hoge"}
    condition             {"hoge"}
    shipping_fee          {"hoge"}
    shipping_how          {"hoge"}
    shipping_from         {"hoge"}
    shipping_date         {"hoge"}
    price                 {1000}
    likes_count           {0}
    created_at { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    association :user, factory: :user
  end

end