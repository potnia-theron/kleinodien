# TODO: add tests for Import::MusicbrainzSession
module Import
  class MusicbrainzSession < Session
    def factory
      @factory ||= Import::MusicbrainzFactory.new(self)
    end

    delegate_missing_to :factory
    delegate :lock, to: :buffer
    delegate :locked?, to: :buffer

    def deep_dup_buffer
      buffer.deep_dup
    end

    # def get(kind, code)
    #   buffer.fetch(kind, code) || fetch(kind, code)
    # end
    def get(*params)
      buffer.fetch(*params) { build_fetcher(*params).get }
      # buffer.fetch(kind, code)#  { build_fetcher(kind, code).get }
    end

    private

    def fetch(kind, code)
      uri_string = build_uri_string(kind, code)
      fetcher = build_fetcher(uri_string)
      buffer.fetch(kind, code) { fetcher.get }
    end
  end
end
