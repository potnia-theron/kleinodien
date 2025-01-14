require "test_helper"
require "support/web_mock_external_apis"

class Import::ImportAParticipantFromMusicbrainzTest < ActiveSupport::TestCase
  setup do
    WebMockExternalApis.setup
  end

  test "create a Participant" do
    # code = "66c662b6-6e2f-4930-8610-912e24c63ed1"
    code = "2280ca0e-6968-4349-8c36-cb0cbd6ee95f" # Jello Biafra
    user = users(:kim)
    import_order = MusicbrainzImportOrder.create!(code: code, kind: "participant", user: user)

    participant = import_order.perform

    assert_equal "Jello Biafra", participant.name
    assert_not participant.new_record?
    assert import_order.done?
  end
end
