module LayeredImport
  class ReflectionsBuilder
    CLASS_PREFIX = "LayeredImport::"
    CLASS_SUFFIX = "Reflections"

    def self.build_reflection(kind)
      new(kind).build_reflection
    end

    def initialize(kind)
      @kind = kind
    end

    attr_reader :kind

    def build_reflection
      record_class_name = kind.to_s.classify

      # TODO: remove this dirty hack
      record_class_name = "Archetype" if record_class_name == "AlbumArchetype"

      class_name = [CLASS_PREFIX, record_class_name, CLASS_SUFFIX].join
      class_name.constantize.new
    end

    def build_delegated_reflection
      record_class_name = kind.to_s.classify

      class_name = [CLASS_PREFIX, record_class_name, CLASS_SUFFIX].join
      class_name.constantize.new
    end
  end
end
