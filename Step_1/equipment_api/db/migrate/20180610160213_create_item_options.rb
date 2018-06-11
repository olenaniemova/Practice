class CreateItemOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :item_options do |t|
      t.belongs_to :item
      t.belongs_to :filter_option
    end
  end
end
