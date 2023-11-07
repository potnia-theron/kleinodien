require "test_helper"

class IncompleteDateTest < ActiveSupport::TestCase
  setup do
    @subject = IncompleteDate.new(Time.zone.today, :day)
  end

  def test_accessors
    assert_respond_to(@subject, :date)
    assert_respond_to(@subject, :accuracy)
  end
end
