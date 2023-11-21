require "sinatra/base"

# Mock API calls to https://musicbrainz.org
class WebMockMusicBrainz < Sinatra::Base
  get "/ws/2/:kind/:id" do
    content_type :json
    status 200

    path = "test/webmock/musicbrainz.org/ws/2/#{params[:kind]}/#{params[:id]}.json"
    json_string = File.read(path)

    return json_string if json_string

    status 404
    nil
  end
end
