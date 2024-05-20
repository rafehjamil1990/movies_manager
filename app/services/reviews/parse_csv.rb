# frozen_string_literal: true

require 'csv'

module Reviews
  class ParseCsv
    include CsvParser

    def initialize(import_id)
      @import = Import.find_by(id: import_id)
      @csv_string = @import.csv.download
    end

    def execute
      @import.begin_import
      parsed_csv.by_row.each_with_index do |row, i|
        i += 2 # to represent the actual row in the csv
        Rails.logger.debug "Processing row #{i}"
        initialize_or_find_review(row, i)
      end

      calculate_average_rating

      @import.end_import
    rescue => e
      @import.add_import_error(e.message)
    end

    def initialize_or_find_review(row, index)
      row_hash = row.to_h
      params = review_params(row_hash)

      movie = Movie.find_by(name: params[:movie_name])

      return if movie.blank?

      Review.find_or_create_by!(movie_id: movie.id, user: params[:user], stars: params[:stars], review: params[:review])
    end

    def review_params(row_hash)
      {
        movie_name: row_hash['Movie'],
        stars: row_hash['Stars'].to_i,
        user: row_hash['User'],
        review: row_hash['Review']
      }
    end

    def calculate_average_rating
      avg_ratings = Review.select('AVG(reviews.stars) as avg_rating, movie_id').group('movie_id')
      avg_ratings.each do |avg_rating|
        Movie.where(id: avg_rating['movie_id']).update_all(avg_rating: avg_rating['avg_rating'])
      end
    end
  end
end
