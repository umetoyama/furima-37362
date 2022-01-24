FactoryBot.define do
  factory :item do
    product_name     { Faker::Commerce.product_name }
    description      { Faker::Lorem.sentence }
    category_id      { Faker::Number.within(range: 2 .. 3 ) }
    condition_id     { Faker::Number.within(range: 2 .. 3 ) }
    shipping_cost_id { Faker::Number.within(range: 2 .. 3 ) }
    prefecture_id    { Faker::Number.within(range: 2 .. 3 ) }
    shipping_time_id { Faker::Number.within(range: 2 .. 3 ) }
    price            { Faker::Commerce.price(range: 300..9_999_999) }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/008.jpeg'), filename: '008.jpeg')
    end
  end
end
