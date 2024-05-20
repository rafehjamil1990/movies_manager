class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :name
      t.text :description
      t.string :year
      
      t.references :director
      t.references :filming_location
      t.references :country

      t.timestamps
    end
  end
end
