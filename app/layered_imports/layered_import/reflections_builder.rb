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

    def build_reflection
      class_name_for(kind).constantize.new
    end

    def build_delegated_reflection
      class_name_for(kind).constantize.new
    end

    private

    attr_reader :kind

    def delegated_type
      reflections = build_delegated_reflection
      reflections.delegated_type_of
    end

    def class_name_for(infix)
      classified = infix.to_s.classify
      [CLASS_PREFIX, classified, CLASS_SUFFIX].join
    end
  end
end
