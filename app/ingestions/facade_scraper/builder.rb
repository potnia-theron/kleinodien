module FacadeScraper
  class Builder
    def self.call(&)
      architect = new
      architect.instance_eval(&)

      callbacks = architect.callbacks.freeze
      ->(facade) { Scraper.new(callbacks, facade) }
    end

    def initialize
      @callbacks = {}.with_indifferent_access
    end

    attr_reader :callbacks

    def define(attr, *arguments, **options)
      attr = attr.to_sym
      arguments = arguments.map(&:to_sym)

      callbacks[attr] = callback_for(attr, arguments, options)
    end

    private

    def callback_for(attr, arguments, options)
      matchable = [arguments, options]

      case matchable
      in [[], {always:}]
        ->(_) { always }
      in [[], {callback:}]
        callback
      in [[], {}]
        ->(facade) { facade.data[attr] }
      else
        ->(facade) { facade.data.dig(*arguments) }
      end
    end
  end
end
