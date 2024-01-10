require "pathname"

module Retrieve
  # MusicBrainz data by kind and code.
  # Lookup data under test/webmock/musicbrainz.org/ws/2/#{kind}.
  # We assume that the file with the longest name contains the most data.
  # When more then one file "matches" code than return data form the file with
  # the longest filename.
  class Musicbrainz
    def initialize(kind, code)
      @kind = kind.to_s
      @code = code.to_s
    end

    def retrieve
      file = dir.join(longest_filename)
      file.read
    end

    private

    attr_reader :kind, :code

    def base_path
      File.join("test", "webmock", "musicbrainz.org", "ws", "2", kind)
    end

    def dir
      @dir ||= Pathname.new(base_path)
    end

    def longest_filename
      regex = %r{#{code}}
      dir.opendir.grep(regex).max_by(&:length)
    end
  end
end
