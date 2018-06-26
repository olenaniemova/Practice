FactoryBot.define do
  factory :city, aliases: [:city_id] do
    name 'Kyiv'
  end

  factory :user, aliases: [:user_id] do
    first_name 'John'
    last_name  'Doe'
    email 'juser@example.com'
    city_id
  end

  factory :category, aliases: [:category_id] do
    title 'Jacket'
  end

  factory :item, aliases: [:item_id] do
    title 'Skiing'
    description 'Very cool skis'
    daily_price 85
    user_id
    category_id
  end

  factory :filter, aliases: [:filter_id] do
    title 'Size'
  end

  factory :filter_option do
    filter_id
    value 38
  end

  factory :booking do
    item_id
    start_date '2018-06-01 12:00:00'
    end_date '2018-06-04 18:00:00'
    user_id
  end
end
