class CreateFilterOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :filter_options do |t|
      t.string :value
      t.belongs_to :filter
    end
  end
end
