module LayeredImport
  class FacadeLayer
    def initialize(import_order)
      @import_order = import_order
    end

    attr_reader :import_order

    def build_facade(reflections, options)
      reflections
        .base_class
        .name
        .dup # reflections.base_class.name returns a frozen string so we create a new one
        # TODO: stop using "LayeredImport::Musicbrainz" as prefix for the facade-class
        .prepend("LayeredImport::Musicbrainz")
        .concat("Facade")
        .constantize
        .new(self, options)
    end
  end
end
