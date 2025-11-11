module IngestionReflections
  class Participant < Default
    def record_class = ::Participant

    def create_finder = factory.create_finder(::Participant)
  end
end
