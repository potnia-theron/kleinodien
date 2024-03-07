module Import
  class MusicbrainzParticipantFacade
    def initialize(session, data:, **options)
      @session = session
      @data = data
      @options = options
    end

    attr_reader :options, :session

    def model_class = Participant

    def data
      @xxx = @data || get
    end

    def get
      session.get(:artist, options[:code])
    end

    def properties
      @properties ||= session.build_properties(model_class)
    end

    delegate_missing_to :properties

    def intrinsic_code
      # data.id
    end

    def all_codes = nil

    delegate :name, to: :data
    delegate :sort_name, to: :data

    def disambiguation = nil

    def begin_date = nil

    def begin_date_accuracy = nil

    def end_date = nil

    def end_date_accuracy = nil

    def all_codes = []

    def attributes
      properties.coining_attributes.index_with { |attr_name| send(attr_name) }
    end
  end
end
