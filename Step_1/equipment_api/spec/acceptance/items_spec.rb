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
