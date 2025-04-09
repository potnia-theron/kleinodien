require "sinatra/base"
require "support/retrieve"

# Mock API calls to https://musicbrainz.org
class WebMockMusicBrainz < Sinatra::Base
  get "/ws/2/:kind/:code" do
    content_type :json
    status 200

    kind = params[:kind].tr("_", "-")
    code = params[:code]
    inc = env.dig("rack.request.query_hash", "inc").split(" ")
    json_string = retriever.call(kind, code, inc)

    return json_string if json_string

    Rails.logger.info("failed to get #{kind} #{code}")

    status 404
    nil
  end

  def retriever = @retriever ||= Retrieve::Musicbrainz.new
end
