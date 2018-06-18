class AddDailyPriceToItem < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :daily_price, :float
  end
end
