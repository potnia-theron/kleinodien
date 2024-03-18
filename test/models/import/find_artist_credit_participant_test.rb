require "test_helper"

class Import::FindArtistCreditParticipantTest < ActiveSupport::TestCase
  test ".new" do
    assert Import::FindArtistCreditParticipant.new
    assert Import::FindArtistCreditParticipant.new("it", :does, %w[not care], about: "options")
  end

  test "#call" do
    assert_nil Import::FindArtistCreditParticipant.new.call
  end
end
