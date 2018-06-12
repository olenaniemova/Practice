class CreateJoinTableCategoryFilter < ActiveRecord::Migration[5.1]
  def change
    create_join_table :categories, :filters do |t|
       t.index [:category_id, :filter_id]
       t.index [:filter_id, :category_id]
    end
  end
end
