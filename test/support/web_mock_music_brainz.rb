require "sinatra/base"
require "support/retrieve"

# Mock API calls to https://musicbrainz.org
class WebMockMusicBrainz < Sinatra::Base
  get "/ws/2/:kind/:id" do
    content_type :json
    status 200

    kind = params[:kind].tr("_", "-")
    code = params[:id]
    json_string = Retrieve.musicbrainz(kind, code)

    return json_string if json_string

    Rails.logger.info("failed to get #{kind} #{code}")

    status 404
    nil
  end
end
