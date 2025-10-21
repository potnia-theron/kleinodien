module Ingestion
  class NullPersister
    def initialize(*) = nil

    def call(*) = nil

    def active? = false
  end
end
