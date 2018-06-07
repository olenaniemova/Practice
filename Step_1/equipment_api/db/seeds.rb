
# ruby encoding: utf-8

c = City.create(name: 'Lviv')
c.save

user1 = User.create(last_name: 'user', first_name: 'user', email: 'current_user@example.com', city_id: c.id)
user2 = User.create(last_name: 'n', first_name: 'lena', email: 'ln@example.com', city_id: c.id)
user1.save
user2.save

i1 = Item.create(title: 'Skiing', description: 'Very cool skis', user_id: user1.id)
i2 = Item.create(title: 'Ski suit', description: 'New ski suit', user_id: user1.id)
Item.create(title: 'Snowboard', description: 'Snowboard is in good condition', user_id: user1.id)
i1.save
i2.save

Booking.create(item_id: i1.id, start_date: '2018-06-01 12:00:00', end_date: '2018-06-04 18:00:00', user_id: user2.id)
Booking.create(item_id: i2.id, start_date: '2018-06-01 12:00:00', end_date: '2018-06-04 18:00:00', user_id: user2.id)

Review.create(title: 'Review for skiing', text: 'Very good skiing!', user_id: user2.id,
              reviewable_type: 'Item', reviewable_id: i1.id)
Review.create(title: 'Review for ski suit', text: 'Cool suit!!', user_id: user2.id,
              reviewable_type: 'Item', reviewable_id: i2.id)
Review.create(title: 'Rent', text: 'Responsible tenant', user_id: user1.id,
              reviewable_type: 'User', reviewable_id: user2.id)
