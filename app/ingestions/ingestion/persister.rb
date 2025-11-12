module Ingestion
  class Persister
    def call(record)
      record.save!
    rescue
      debugger
    end

    def active? = true
  end
end
