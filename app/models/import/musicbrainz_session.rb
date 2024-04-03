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

    def get(*params)
      buffer.fetch(*params) { build_fetcher(*params).get }
      # buffer.fetch(kind, code)#  { build_fetcher(kind, code).get }
    end
  end
end
