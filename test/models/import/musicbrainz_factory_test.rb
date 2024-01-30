require "test_helper"
require "minitest/mock"

class Import::MusicbrainzFactoryTest < ActiveSupport::TestCase
  setup do
    @factory = Import::MusicbrainzFactory.new(:fake_import_order)
  end

  test "#build_attempt returns an Import::Faradaybuild_attempt" do
    assert_kind_of Import::FaradayAttempt, @factory.build_attempt
  end

  test "#build_fetcher returns an Import::Fetcher" do
    assert_kind_of Import::Fetcher, @factory.build_fetcher("https://example.com")
  end

  test "#build_uri_string builds the expected uri_string" do
    assert_equal @factory.build_uri_string(:artist, "66c662b6-6e2f-4930-8610-912e24c63ed1"), "https://musicbrainz.org/ws/2/artist/66c662b6-6e2f-4930-8610-912e24c63ed1?fmt=json"
  end

  test "#buffer returns an Import::Buffer" do
    assert_kind_of Import::Buffer, @factory.buffer
  end

  test "#connection returns a Faraday::Connection" do
    assert_kind_of Faraday::Connection, @factory.connection
  end

  test "#interrupter returns an Import::MusicbrainzInterrupter" do
    assert_kind_of Import::MusicbrainzInterrupter, @factory.interrupter
  end

  test "#max_tries" do
    import = Minitest::Mock.new
    import.expect "[]", {max_tries: 999}, [:musicbrainz]

    configuration = Minitest::Mock.new
    configuration.expect :import, import

    Rails.stub :configuration, configuration do
      assert_equal @factory.max_tries, 999
    end

    configuration.verify
    import.verify
  end
end
