require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Items', :type => :controller do
  header 'Content-Type', 'application/json'

  let(:city) { City.create(name: 'Lviv') }
  let(:user) { User.create(last_name: 'user', first_name: 'user', email: 'current_user@example.com', city_id: city.id) }
  let(:categ) { Category.create(title: 'Jacket') }
  let(:item) { Item.create(title: 'Skiing', description: 'Very cool skis', user_id: user.id, category_id: categ.id) }

  get '/items' do
    parameter :page, 'Page to view'
    parameter :per_page, 'Number of items per page'

    before do
      3.times do |i|
        Item.create(title: "Skiing ##{i}", description: 'Very cool skis', user_id: user.id, category_id: categ.id)
      end
    end

    example_request 'Get a list of all items' do
      expect(response_body).to eq(Item.all.to_json)
      expect(status).to eq(200)
    end

    example_request 'Get page 2 (last item)', :page => 2, :per_page => 2 do
      expect(response_body).to eq("[#{Item.last.to_json}]")
      expect(status).to eq(200)
    end

    example_request 'Get empty list on page 3', :page => 3, :per_page => 2 do
      expect(response_body).to eq('[]')
      expect(status).to eq(200)
    end
  end

  get '/items/:id' do
    let(:id) { item.id }
    example_request 'Getting a specific item' do
      expect(response_body).to eq(item.to_json)
      expect(status).to eq(200)
    end
  end

  delete '/items/:id' do
    let(:id) { item.id }
    example_request 'Deleting an item' do
      expect(status).to eq(204)
    end
  end

  post '/items' do
    with_options scope: :item do
      parameter :title, 'Title of item'
      parameter :description, 'Description of item'
      parameter :user_id, 'Author of item'
      parameter :category_id, 'Category of item'
    end

    let(:raw_post) { params.to_json }
    let(:title) { 'Title 1' }
    let(:description) { 'Item description' }
    let(:user_id) { user.id }
    let(:category_id) { categ.id }

    example_request 'Creating an item' do
      expect(status).to eq(201)
    end
  end

  put '/items/:id' do
    parameter :title, 'Title of item', :scope => :item
    parameter :description, 'Description of item', :scope => :item
    parameter :user_id, 'Author of item', :scope => :item
    parameter :category_id, 'Category of item', :scope => :item

    let(:id) { item.id }
    let(:title) { 'Updated Title' }
    let(:raw_post) { params.to_json }

    example_request 'Updating an item' do
      expect(status).to eq(200)
    end
  end
end

RSpec.describe Item, type: :model do
  let(:city) { City.create(name: 'Lviv') }
  let(:user) { User.create(last_name: 'user', first_name: 'user', email: 'current_user@example.com', city_id: city.id) }
  let(:categ) { Category.create(title: 'Jacket') }
  let(:item1) { Item.create(title: 'Skiing', description: 'Very cool skis', daily_price: 60, user_id: user.id, category_id: categ.id) }
  let(:item2) { Item.create(title: 'Skiing', description: 'Very cool skis', daily_price: 80, user_id: user.id, category_id: categ.id) }
  let(:filter1) { Filter.create(title: 'Size') }
  let(:filter2) { Filter.create(title: 'Color') }
  let(:filter_opt1) { FilterOption.create(filter_id: filter1.id, value: 38) }
  let(:filter_opt2) { FilterOption.create(filter_id: filter2.id, value: 'Black') }
  let(:booking) { Booking.create(item_id: item1.id, start_date: '2018-06-01 12:00:00', end_date: '2018-06-04 18:00:00', user_id: user.id)}


  it 'by title' do
    expect(Item.by_title(item1.title).to_sql).to eq Item.where('title ~* ?', item1.title).to_sql
  end

  it 'by category' do
    expect(Item.by_category(categ.id)).to eq Item.where(category_id: categ.id)
  end

  it 'by option' do
    categ.filters << filter1
    categ.filters << filter2
    item1.filter_options << filter_opt1
    item1.filter_options << filter_opt2
    expect(Item.by_option(filter_opt1.id)).to eq Item.joins(:filter_options).where(filter_options: { id: filter_opt1.id })
  end

  it 'by price_range' do
    p_s = 100
    p_e = 200
    d = 2
    expect(Item.by_price_range(p_s, p_e, d)).to eq Item.where(daily_price: (p_s / d)..(p_e / d))
  end

  it 'by date range' do
    d_s = '2018-06-01'
    d_e = '2018-06-03'
    b_start = Booking.where(start_date: d_s..d_e)
    b_end = Booking.where(end_date: d_s..d_e)
    booking_items = Booking.where(b_start.or(b_end)).distinct.pluck(:item_id)
    items = Item.where.not(id: booking_items)

    expect(Item.by_date_range(d_s, d_e)).to eq items
  end
end
