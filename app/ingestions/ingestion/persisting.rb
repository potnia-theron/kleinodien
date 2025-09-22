module Ingestion
  class Persisting < Buffering
    def call
      super
      record.save!
      record
    end
  end
end
