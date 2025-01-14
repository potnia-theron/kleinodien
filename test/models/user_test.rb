require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:kim)
  end

  def test_user_can_create_a_music_brainz_import_order
    assert_difference("MusicbrainzImportOrder.count") do
      @user.musicbrainz_import_orders.create!(code: "9b6da394-dedc-11ed-9694-937ccc9fa222", kind: :release)
    end
  end
end
