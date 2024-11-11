module Import
  class CollectAction < Import::BaseAction
    # Copy paste from create_action
    def initialize(session, facade:, **options)
      @options = options
      super(session, facade: facade)
    end

    attr_reader :options

    def continue
      # debugger
      return if facade.buffered?
      super
      # facade
    end

    def foreign_attributes
      super.compact.transform_values do |foreign_facade|
        next if foreign_facade.buffered?
        action = session.build_collect_action(facade: foreign_facade)
        # debugger
        action.call
      end
    end

    # BUG: must return what it promises
    def has_many_associations
      # has_and_belongs_to_many_associations = properties.has_and_belongs_to_many_associations
      # associations = has_and_belongs_to_many_associations.reject do |association|
      has_many_associations = properties.has_many_associations
      # associations = has_many_associations.reject do |association|
      #   name = association.inverse_of.name
      #   options&.defined? "skip_#{name}"
      # end
      # properties.has_many_associations.each { |association| gather_one_has_many_association(association) }
      # debugger
      has_many_associations.each { |association| gather_one_has_many_association(association) }
    end

    def gather_one_has_many_association(association)
      facade_list = facade.send(association.name)
      unbuffered_facades = facade_list.reject { |facade| facade.buffered? }

      unbuffered_facades.each do |unbuffered_facade|
        action = session_build_collect_action(facade: unbuffered_facade)
        action.call
      end

      # Bug: bad evil
      # session.build_collect_action(facade: facade).call
    end
  end
end
