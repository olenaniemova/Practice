require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Items", :type => :controller do

  let(:city) { City.create(name: 'Lviv') }
  let(:user) { User.create(last_name: 'user', first_name: 'user', email: 'current_user@example.com', city_id: city.id) }
  let(:categ) { Category.create(title: 'Jacket') }
  let(:item) { Item.create(title: 'Skiing', description: 'Very cool skis', user_id: user.id, category_id: categ.id) }

  get "/items" do
    parameter :page, "Page to view"
    parameter :per_page, "Number of items per page"

    before do
      3.times do |i|
        Item.create(title: "Skiing ##{i}", description: 'Very cool skis', user_id: user.id, category_id: categ.id)
      end
    end

    example "Listing items", :document => false do
      expect(response.status).to eq(200)
    end

    example "Get a list of all items" do
      do_request
      status.should eq(200)
      response_body.should eq(Item.all.to_json)
    end

    example "Get a list on page 2 (last item)" do
      do_request(:page => 2, :per_page => 2)
      status.should eq(200)
      response_body.should eq("[#{Item.last.to_json}]")
    end

    example "Get empty list on page 3" do
      do_request(:page => 3, :per_page => 2)
      status.should eq(200)
      response_body.should eq('[]')
    end
  end

  get "/items/:id" do
    let(:id) { item.id }

    example "Getting a specific item" do
      do_request
      expect(response_body).to eq(item.to_json)
      expect(status).to eq(200)
    end
  end

  delete "/items/:id" do
    let(:id) { item.id }

    example_request "Deleting an item" do
      expect(status).to eq(204)
    end
  end

  post "/items" do
    with_options scope: :item do
      parameter :title, "Title of item"
      parameter :description, "Description of item"
      parameter :user_id, "Description of item"
      parameter :category_id, "Description of item"
    end
    # parameter :title, "Title of item", :required => true, :scope => :item
    # parameter :description, "Description of item", :required => true, :scope => :item
    # parameter :user_id, "Description of item", :scope => :item
    # parameter :category_id, "Description of item"

    let(:raw_post) { params.to_json }

    let(:title) { "Title 1" }
    let(:description) { "Item description" }
    let(:user_id) { user.id }
    let(:category_id) { categ.id }


    example_request "Creating an item" do
      explanation "First, create an item, then make a later request to get it back"

      i = JSON.parse(response_body)
      expect(i.except("id", "created_at", "updated_at")).to eq({
        "title" => title,
        "description" => description,
        "user_id" => user_id,
        "category_id" => category_id,
      })
      expect(status).to eq(201)
    end
  end

  put "/items/:id" do
    parameter :title, "title of order", :scope => :item
    parameter :description, "If the order has been paid for", :scope => :item
    parameter :user_id, "Email of user that placed the order", :scope => :item
    parameter :category_id, "Email of user that placed the order", :scope => :item

    let(:id) { item.id }
    let(:title) { "Updated Title" }

    let(:raw_post) { params.to_json }

    example_request "Updating an item" do
      expect(status).to eq(200)
    end
  end
end

# RSpec.describe ItemsController, :type => :controller do
#   describe "responds to" do
#     it "index" do
#       get :index
#       expect(response.status).to eq(200)
#     end
#
#     it "responds to custom formats when provided in the params" do
#       post :create, :params => { :item => { :title => "Any title" }, :format => :json }
#       expect(response.content_type).to eq "application/json"
#       expect(response.content_type).to eq "application/json"
#     end
#   end
# end
