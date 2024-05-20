class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.text :review
      t.integer :stars
      t.string :user

      t.references :movie

      t.timestamps
    end
  end
end
