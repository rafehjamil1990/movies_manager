class Import < ApplicationRecord

  has_one_attached :csv

  IMPORT_CLASSES = {
    movies: 'movies',
    reviews: 'reviews'
  }

  # enum import_class: IMPORT_CLASSES.keys

  def process_import
    "#{self.import_class.titleize}::ParseCsv".constantize.new(self.id).execute
  end

  def begin_import
    update(started_at: DateTime.now, import_errors: {})
  end

  def end_import
    update(ended_at: DateTime.now)
  end

  def add_import_error(error_message)
    update(import_errors: error_message)
  end
end
