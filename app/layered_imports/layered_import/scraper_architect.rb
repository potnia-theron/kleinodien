module LayeredImport
  class ScraperArchitect
    def self.build(&)
      architect = new
      architect.instance_eval(&)

      callbacks = architect.callbacks.freeze
      LayeredImport::ScraperBuilder.new(callbacks)
    end

    def define(attr, *arguments, **options)
      attr = attr.to_sym
      arguments = arguments.map(&:to_sym)

      callbacks[attr] = define_by_options(attr, arguments, options) \
        || define_by_arguments(attr, arguments, options)
    end

    def define_by_options(attr, arguments, options)
      return if options.none?

      case options
      in {always:}
        ->(_) { always }
      in {callback: callable}
        callable
      else
        nil
      end
    end

    def define_by_arguments(attr, arguments, options)
      case arguments
      in []
        ->(facade) { facade.data[attr] }
      else
        ->(facade) { facade.data.dig(*attr) }
      end
    end

    def initialize
      @callbacks = {}.with_indifferent_access
    end

    attr_reader :callbacks
  end
end
