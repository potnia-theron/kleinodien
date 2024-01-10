require "pathname"

module Retrieve
  class Musicbrainz
    def initialize(kind, code)
      @kind = kind.to_s
      @code = code.to_s
    end

    attr_reader :kind, :code

    def retrieve
      dir_path = Pathname.new("test/webmock/musicbrainz.org/ws/2/#{kind}")
      dir = dir_path.opendir

      file_name = dir
        .grep(%r{#{code}})
        .max_by(&:length)

      path = dir_path.join(file_name)
      File.read(path)
    end
  end
end
