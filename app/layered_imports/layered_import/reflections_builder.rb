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
      infix = kind.to_s.classify
      class_name = [CLASS_PREFIX, infix, CLASS_SUFFIX].join
      class_name.constantize.new
    end
  end
end
