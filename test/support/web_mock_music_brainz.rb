require "sinatra/base"
require "support/retrieve"

# Mock API calls to https://musicbrainz.org
class WebMockMusicBrainz < Sinatra::Base
  get "/ws/2/:kind/:id" do
    content_type :json
    status 200

    # path = "test/webmock/musicbrainz.org/ws/2/#{params[:kind]}/#{params[:id]}.json"
    # json_string = File.read(path)
    # debugger
    kind = params[:kind].tr("_", "-")
    # json_string = Retrieve.musicbrainz(params[:kind], params[:id])
    json_string = Retrieve.musicbrainz(kind, params[:id])

    return json_string if json_string

    status 404
    nil
  end
end
