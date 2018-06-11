class CreateCategoryFilters < ActiveRecord::Migration[5.1]
  def change
    create_table :category_filters do |t|
      t.belongs_to :category
      t.belongs_to :filter
    end
  end
end
