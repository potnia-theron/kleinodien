module Ingestion
  class Persister
    def call(record) = record.save!

    def active? = true
  end
end
