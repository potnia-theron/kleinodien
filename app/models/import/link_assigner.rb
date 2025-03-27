module Import
  class LinkAssigner
    include Callable

    LINK_KINDS = %i[url].freeze

    def initialize(adapter_layer, entity, facade, reflections)
      @adapter_layer = adapter_layer
      @entity = entity
      @facade = facade
      @reflections = reflections
    end

    def call
      return unless reflections.linkable?

      link_kinds.each { |kind| assign_links(kind) }
    end

    private

    attr_reader :adapter_layer, :entity, :facade, :reflections
    delegate_missing_to :adapter_layer

    def assign_links(kind)
      link_message = "#{kind}_links"
      links = link_facade.send(link_message)

      links.each do |link|
        target = supply_entity(kind, link[:options])
        link_kind = supply_entity("LinkKind", {name: link[:kind]})
        Link.build(source: entity.central, destination: target.central, link_kind: link_kind)
      end
    end

    def link_facade = @link_facade ||= facade.links

    def link_kinds = LINK_KINDS
  end
end
