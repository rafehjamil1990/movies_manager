# frozen_string_literal: true

require 'csv'

module Movies
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
        initialize_or_find_movie(row, i)
      end

      @import.end_import
    rescue => e
      @import.add_import_error(e.message)
    end

    def initialize_or_find_movie(row, index)
      row_hash = row.to_h
      params = movie_params(row_hash)

      actor = Actor.find_or_create_by!(name: params[:actor])
      director = Director.find_or_create_by!(name: params[:director])
      filming_location = FilmingLocation.find_or_create_by!(name: params[:filming_location])
      country = Country.find_or_create_by!(name: params[:country])

      movie = Movie.find_or_create_by!(
        name: params[:name], description: params[:description], director_id: director.id, 
        filming_location_id: filming_location.id, country_id: country.id, year: params[:year]
      )

      movies_actor = MoviesActor.find_or_create_by!(movie_id: movie.id, actor_id: actor.id)
    end

    def movie_params(row_hash)
      {
        name: row_hash['Movie'],
        description: row_hash['Description'],
        director: row_hash['Director'],
        actor: row_hash['Actor'],
        filming_location: row_hash['Filming location'],
        country: row_hash['Country'],
        year: row_hash['Year']
      }
    end
  end
end
