require "test_helper"

class StubImportBuffer
  def fetch(*)
    :something
  end
end

class Import::DomainBufferTest < ActiveSupport::TestCase
  setup do
    buffer = StubImportBuffer.new
    @domain_buffer = Import::DomainBuffer.new(buffer, "some-key")
  end

  test "fetch" do
    assert_equal @domain_buffer.fetch(:foo, "bar") { :baz }, :something
    assert_equal @domain_buffer.fetch(:foo, "bar"), :something
  end
end
