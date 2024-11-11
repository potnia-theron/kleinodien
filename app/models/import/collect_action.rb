module Import
  class CollectAction < Import::BaseAction
    def initialize(session, facade:, **options)
      @options = options
      super(session, facade: facade)
    end

    attr_reader :options

    def continue
      return if facade.buffered?
      super
    end

    def foreign_attributes
      super.compact.transform_values do |foreign_facade|
        next if foreign_facade.buffered?
        action = session.build_collect_action(facade: foreign_facade)
        action.call
      end
    end

    def has_many_associations
      has_many_associations = properties.has_many_associations
      has_many_associations.each { |association| gather_one_has_many_association(association) }
    end

    def gather_one_has_many_association(association)
      facade_list = facade.send(association.name)
      unbuffered_facades = facade_list.reject { |facade| facade.buffered? }

      unbuffered_facades.each do |unbuffered_facade|
        action = session_build_collect_action(facade: unbuffered_facade)
        action.call
      end
    end
  end
end
