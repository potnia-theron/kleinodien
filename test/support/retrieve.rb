require "pathname"

class Retrieve
  def self.musicbrainz(kind, code)
    dir_path = Pathname.new("test/webmock/musicbrainz.org/ws/2/#{kind}")
    dir = dir_path.opendir

    file_name = dir
      .grep(%r{#{code}})
      .max_by(&:length)

    path = dir_path.join(file_name)
    File.read(path)
  end
end
