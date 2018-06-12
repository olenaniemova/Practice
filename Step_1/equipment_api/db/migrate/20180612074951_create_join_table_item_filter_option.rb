class CreateJoinTableItemFilterOption < ActiveRecord::Migration[5.1]
  def change
    create_join_table :items, :filter_options do |t|
       t.index [:item_id, :filter_option_id]
       t.index [:filter_option_id, :item_id]
    end
  end
end
