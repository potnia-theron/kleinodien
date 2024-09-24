require "test_helper"
require "support/web_mock_external_apis"

class Import::ImportAParticipantFromMusicbrainzTest < ActiveSupport::TestCase
  setup do
    WebMockExternalApis.setup
  end

  test "create a Participant" do
    code = "66c662b6-6e2f-4930-8610-912e24c63ed1"
    user = users(:kim)
    import_order = MusicBrainzImportOrder.create!(code: code, kind: "participant", user: user)
    participant = import_order.perform

    name = participant.name
    debugger if name.is_a? Symbol
    assert_equal "AC/DC", participant.name
    assert_not participant.new_record?
  end
end
