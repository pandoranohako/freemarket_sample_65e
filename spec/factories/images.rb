FactoryBot.define do

  factory :image do
    image              {"hoge/hoge"}
    association :product, factory: :product
  end

end