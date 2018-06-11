class RemoveDatetimeFromFilters < ActiveRecord::Migration[5.1]
  def change
    remove_column :filters, :created_at, :datetime
    remove_column :filters, :updated_at, :datetime
  end
end
