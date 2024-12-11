module LayeredImport
  class WorkflowBuilder
    def self.build(...)
      new(...).build
    end

    def initialize(order)
      @order = order
    end

    attr_reader :order
    delegate :kind, to: :order
    delegate :type, to: :order

    def build
      case type
      when "MusicBrainzImportOrder"
        build_musicbrainz_workflow
      else
        raise "can't build workflow for #{type}"
      end
    end

    def build_musicbrainz_workflow
      LayeredImport::MusicbrainzWorkflow.new(order)
    end
  end
end
