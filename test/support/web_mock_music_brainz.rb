require "sinatra/base"

# Mock API calls to https://musicbrainz.org
class WebMockMusicBrainz < Sinatra::Base
  get "/ws/2/:type/:id" do
    content_type :json
    status 200
    json_string = '{"hello": "world"}'
    return json_string if json_string

    status 404
    nil
  end
end
