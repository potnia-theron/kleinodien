module LayeredImport
  class WorkflowBuilder
    def self.build(...)
      new(...).build
    end

    def initialize(import_order)
      @import_order = import_order
    end

    attr_reader :import_order
    delegate :kind, to: :import_order
    delegate :type, to: :import_order

    def build
      case type
      when "MusicBrainzImportOrder"
        build_musicbrainz_workflow
      else
        raise "can't build workflow for #{type}"
      end
    end

    def build_musicbrainz_workflow
      LayeredImport::MusicbrainzWorkflow.new(import_order)
    end
  end
end
