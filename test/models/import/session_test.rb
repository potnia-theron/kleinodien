require "test_helper"

class Import::SessionTest < ActiveSupport::TestCase
  setup do
    @from = ::Import::Session.new(:fake_import_order)
  end

  test "#musicbrainz" do
    assert_kind_of Import::SessionAncillary, @from.musicbrainz
  end
end
