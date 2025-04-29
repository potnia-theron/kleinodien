require "test_helper"
require "support/web_mock_external_apis"

class ImportMusicbrainzReleaseJobTest < ActiveJob::TestCase
  setup do
    WebMockExternalApis.setup
  end

  test "imports the release" do
    code = "8866e226-7cd6-414e-b7d2-6ae0b0df6715"
    user = users(:kim)
    import_order = ImportOrder.create!(
      user: user,
      import_orderable_type: "MusicbrainzImportOrder",
      import_orderable_attributes: {code: code, kind: "album-edition"}
    )

    perform_enqueued_jobs do
      ImportMusicbrainzReleaseJob.perform_later(import_order)
    end

    assert Archetype.find_by(title: "Beating Around the Bush")
    # assert import_order.done?
  end
end
