FactoryBot.define do
  factory :order do
    user
    status { Faker::Number.within(range: 1..3) }
  end

  factory :category do
    name { Faker::Food.ingredient }
    priority { Faker::Number.within(range: 5..15) }
  end

  factory :product do
    name { Faker::Food.dish }
    price { Faker::Number.decimal(l_digits: 2) }
    description { Faker::Food.description }
    category
  end

  factory :ordered_product do
    order
    product
    discount
    quontity { Faker::Number.within(range: 1..10) }
    price { Faker::Number.decimal(l_digits: 2) }
  end

  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password {'12345678'}
    role { "user" }
    image { nil }
  end

  factory :discount do
    amount_type {Faker::Number.within(range: 0..1)}
    amount { Faker::Number.within(range: 1..15) }

    trait :product_discount do
      discounted_type { 0 }
      association :discounted, factory: :product
    end
    trait :user_discount do
      discounted_type { 1 }
      association :discounted, factory: :user
    end
    trait :category_discount do
      discounted_type { 2 }
      association :discounted, factory: :category
    end
  end

end
