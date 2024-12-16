require "test_helper"
require "minitest/mock"
require "support/web_mock_external_apis"

class LayeredImport::ImportAParticipantFromMusicbrainzTest < ActiveSupport::TestCase
  setup do
    WebMockExternalApis.setup
  end

  test "import NoMeansNo" do
    code = "37e9d7b2-7779-41b2-b2eb-3685351caad3" # NoMeansNo
    user = users(:kim)
    import_order = MusicBrainzImportOrder.create!(code: code, kind: "participant", user: user)

    participant = LayeredImport.ignite(import_order)

    assert_equal "NoMeansNo", participant.name
  end
end
