class CreateImports < ActiveRecord::Migration[7.1]
  def change
    create_table :imports do |t|
      t.string :import_class
      t.string :import_errors
      t.integer :imported_count

      t.datetime :started_at
      t.datetime :ended_at

      t.timestamps
    end
  end
end
