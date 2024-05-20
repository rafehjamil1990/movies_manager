# frozen_string_literal: true

# Include in any CSV parser classes, for data being imported into our system via CSV.
#
# Provides a `parsed_csv` method, which takes care of all the standard header/value cleaning we need to do,
# and takes care of byte order mark (BOM) issues, common with files exported on windows.
#
# Expects a @csv_string instance variable
#
module CsvParser
  extend ActiveSupport::Concern

  included do
    def parsed_csv
      @parsed_csv ||= self.class.parse(@csv_string)
    end

    def parse_boolean(string)
      return false if string.blank?
      string = string.strip.downcase

      string == "true" || string == "Yes"
    end
  end

  class_methods do
    def parse(csv_string)
      string_io = StringIO.new(csv_string)
      string_io.set_encoding_by_bom

      CSV.parse(
        string_io,
        headers: true,
        # cleanup headers
        header_converters: ->(f) { f.strip },
        # cleanup rows
        converters: lambda do |f|
          f = f&.strip
          f = nil if f == 'null'
          f
        end
      )
    end
  end
end
