class ItemsController < ApplicationController
  before_action :authenticate_user
  before_action :set_item, only: %i[show update destroy]

  has_scope :by_title
  has_scope :by_category
  has_scope :by_option
  has_scope :by_price_range, using: %i[start_pr end_pr days], type: :hash
  has_scope :by_date_range, using: %i[start_d end_d], type: :hash

  def index
    items = apply_scopes(Item).all
    paginate json: items
  end

  def show
    render json: @item
  end

  def create
    item = Item.new(item_params.merge(user_id: current_user.id))
    return render json: item.errors, status: :unprocessable_entity unless item.save
    render :show, status: :created, location: item
  end

  def update
    return render json: @item.errors, status: :unprocessable_entity unless @item.update(item_params)
    render :show, status: :ok, location: @item
  end

  def destroy
    @item.destroy
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:title, :description, :category_id, :daily_price, filter_option_ids: [])
  end
end
