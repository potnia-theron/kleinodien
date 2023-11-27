require "test_helper"

class Import::FromTest < ActiveSupport::TestCase
  setup do
    @from = ::Import::From.new(:fake_import_order)
  end

  test "#musicbrainz" do
    assert_kind_of Import::FromHandler, @from.musicbrainz
  end
end
