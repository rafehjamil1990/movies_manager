class CreateMoviesActor < ActiveRecord::Migration[7.1]
  def change
    create_table :movies_actors do |t|
      t.references :actor
      t.references :movie

      t.timestamps
    end
  end
end
