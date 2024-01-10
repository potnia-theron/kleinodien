require "pathname"

class Retrieve
  def self.musicbrainz(kind, code)
    dir_path = Pathname.new("test/webmock/musicbrainz.org/ws/2/#{kind}")
    dir = dir_path.opendir

    # TODO: min_by is wrong! Use max_by
    # The problem is in Import::MusicbrainzParticipantAdapter
    file_name = dir
      .grep(%r{#{code}})
      .min_by(&:length)

    path = dir_path.join(file_name)
    File.read(path)
  end
end
