class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :text
      t.datetime :date
      t.belongs_to :user, index: true
      t.references :reviewable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
