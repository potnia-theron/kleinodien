module Ingestion
  class Persister
    def call(record)
      record.save!
    rescue => e
      debugger
    end

    def active? = true
  end
end
