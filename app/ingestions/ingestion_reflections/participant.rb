module IngestionReflections
  class Participant < Base
    def record_class = ::Participant

    def create_finder = factory.create_finder(::Participant)
  end
end
