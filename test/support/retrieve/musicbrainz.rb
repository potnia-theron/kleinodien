require "pathname"

module Retrieve
  class Musicbrainz
    BASE_PATH = %w[test webmock musicbrainz.org ws 2].freeze

    def call(kind, code, inc)
      query = inc.sort.join("+")

      filename = File
        .join(*BASE_PATH, kind.to_s, code)
        .then { "#{it}_inc_#{query}.json" }

      Pathname.new(filename).read
    end
  end
end
