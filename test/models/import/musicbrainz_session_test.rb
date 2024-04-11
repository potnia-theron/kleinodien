require "test_helper"

class Import::MusicbrainzSessionTest < ActiveSupport::TestCase
  setup do
    @subject = Import::MusicbrainzSession.new(:fake_import_order)
  end

  test "#factory" do
    assert_kind_of Import::MusicbrainzFactory, @subject.factory
  end
end
