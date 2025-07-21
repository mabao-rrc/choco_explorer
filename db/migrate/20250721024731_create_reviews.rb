class CreateReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :reviews do |t|
      t.references :product, null: false, foreign_key: true
      t.string :reviewer_name
      t.integer :rating
      t.text :comment

      t.timestamps
    end
  end
end
