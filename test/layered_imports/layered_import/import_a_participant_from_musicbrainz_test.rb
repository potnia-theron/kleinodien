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
    assert_equal "1979-01-01", participant.begin_date.to_s
    assert_equal "2016-09-24", participant.end_date.to_s
  end
end
