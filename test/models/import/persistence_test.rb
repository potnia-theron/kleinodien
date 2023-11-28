require "test_helper"
require "minitest/mock"

class Import::PersistenceTest < ActiveSupport::TestCase
  setup do
    @adapter = Minitest::Mock.new
    @persistence = Import::Persistence.new(@adapter)
  end

  test "#create!" do
    @adapter.expect :participants, [{name: "Diana"}, {name: "Artemis"}]
    assert_difference "Participant.count", 2 do
      @persistence.create!
    end
  end
end
