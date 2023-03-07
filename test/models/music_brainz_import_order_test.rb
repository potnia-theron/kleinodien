require "test_helper"
require "shared_import_order_tests"

class MusicBrainzImportOrderTest < ActiveSupport::TestCase
  include SharedImportOrderTests

  setup do
    @import_order = music_brainz_import_orders(:music_brainz_one)
  end
end
