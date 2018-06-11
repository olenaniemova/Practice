require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Items", :type => :controller do
  get "/items" do
    example "Listing items" do
      expect(response.status).to eq(200)
    end

    example "Get a list of all accounts" do
      do_request
      status.should == 200
    end

  end
end


RSpec.describe ItemsController, :type => :controller do
  describe "responds to" do
    it "index" do
      get :index
      expect(response.status).to eq(200)
    end

    it "responds to custom formats when provided in the params" do
      post :create, :params => { :item => { :title => "Any title" }, :format => :json }
      expect(response.content_type).to eq "application/json"
    end
  end
end
