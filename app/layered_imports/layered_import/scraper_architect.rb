module LayeredImport
  class ScraperArchitect
    def self.build(&)
      architect = new
      architect.instance_eval(&)

      callbacks = architect.callbacks.freeze
      LayeredImport::ScraperBuilder.new(callbacks)
    end

    def always(attr, default = nil)
      callbacks[attr] = ->(_) { default }
    end

    def callback(attr, callable)
      callbacks[attr] = callable
    end

    def dig(attr, *keys)
      keys = attr if keys.none?

      callbacks[attr] = ->(facade) { facade.data.dig(*keys) }
    end

    def initialize
      @callbacks = {}.with_indifferent_access
    end

    attr_reader :callbacks
  end
end
