
# ruby encoding: utf-8

city = City.create(name: 'Lviv')

user1 = User.create(last_name: 'user', first_name: 'user', email: 'current_user@example.com', city_id: city.id)
user2 = User.create(last_name: 'n', first_name: 'lena', email: 'ln@example.com', city_id: city.id)

ct1 = Category.create(title: 'Jacket')
ct2 = Category.create(title: 'Equipment')
Category.create(title: 'Boots')
Category.create(title: 'Helmet')

i1 = Item.create(title: 'Skiing', description: 'Very cool skis', user_id: user1.id, category_id: ct2.id)
i2 = Item.create(title: 'Ski suit', description: 'New ski suit', user_id: user1.id, category_id: ct1.id)
Item.create(title: 'Snowboard', description: 'Snowboard is in good condition', user_id: user1.id, category_id: ct2.id)

Booking.create(item_id: i1.id, start_date: '2018-06-01 12:00:00', end_date: '2018-06-04 18:00:00', user_id: user2.id)
Booking.create(item_id: i2.id, start_date: '2018-06-01 12:00:00', end_date: '2018-06-04 18:00:00', user_id: user2.id)

Review.create(title: 'Review for skiing', text: 'Very good skiing!', user_id: user2.id,
              reviewable_type: 'Item', reviewable_id: i1.id)
Review.create(title: 'Review for ski suit', text: 'Cool suit!!', user_id: user2.id,
              reviewable_type: 'Item', reviewable_id: i2.id)
Review.create(title: 'Rent', text: 'Responsible tenant', user_id: user1.id,
              reviewable_type: 'User', reviewable_id: user2.id)

f1 = Filter.create(title: 'Size')
f2 = Filter.create(title: 'Color')
f3 = Filter.create(title: 'Brand')
f4 = Filter.create(title: 'Type')
Filter.create(title: 'Length')
Filter.create(title: 'Material of manufacture')
Filter.create(title: 'Manufacturer country')

ct1.filters << f1
ct1.filters << f2
ct1.filters << f3
ct2.filters << f1
ct2.filters << f3
ct2.filters << f4

fo1 = FilterOption.create(filter_id: f1.id, value: 38)
fo2 = FilterOption.create(filter_id: f1.id, value: 39)
FilterOption.create(filter_id: f1.id, value: 40)
FilterOption.create(filter_id: f1.id, value: 41)
fo3 = FilterOption.create(filter_id: f2.id, value: 'Black')
FilterOption.create(filter_id: f2.id, value: 'White')
FilterOption.create(filter_id: f3.id, value: 'ATOMIC')
fo4 = FilterOption.create(filter_id: f3.id, value: 'SALOMON')
FilterOption.create(filter_id: f3.id, value: 'ROSSIGNOL')
FilterOption.create(filter_id: f3.id, value: 'Volkl')
fo5 = FilterOption.create(filter_id: f4.id, value: 'All Mountain')
FilterOption.create(filter_id: f4.id, value: 'Freeski')

i1.filter_options << fo1
i1.filter_options << fo3
i1.filter_options << fo4
i1.filter_options << fo5
i2.filter_options << fo2
i2.filter_options << fo4
