class ItemsController < ApplicationController
  before_action :authenticate_user
  before_action :set_item, only: %i[show update destroy]

  has_scope :by_title
  has_scope :by_category
  has_scope :by_option
  has_scope :by_price_range, using: %i[start_pr end_pr days], type: :hash
  has_scope :by_date_range, using: %i[start_d end_d], type: :hash

  def index
    if current_user
      items = apply_scopes(Item).all
      paginate json: items
    end
  end

  def show
    render json: @item if current_user
  end

  def create
    if current_user
      item = Item.new(item_params)
      if item.save
        render :show, status: :created, location: item
      else
        render json: item.errors, status: :unprocessable_entity
      end
    end
  end

  def update
    if current_user
      if @item.update(item_params)
        render :show, status: :ok, location: @item
      else
        render json: @item.errors, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @item.destroy if current_user
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:title, :description, :user_id, :category_id, :daily_price, filter_option_ids: [])
  end
end
