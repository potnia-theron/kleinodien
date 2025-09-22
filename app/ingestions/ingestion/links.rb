module Ingestion
  class Links
    include Callable

    LINK_KINDS = %i[url].freeze

    def initialize(calling)
      @calling = calling

      @links_of_kind = {}
    end

    def call
      return unless reflections.linkable?

      link_kinds.each { |kind| assign_links_of(kind) }
    end

    private

    attr_reader :calling
    delegate_missing_to :calling

    def assign_links_of(kind)
      link_facades_of_kind(kind).each do |link_facade|
        link_kind_facade = link_facade.scrape(:link_kind)
        # debugger
        # target = procreate(link_kind_facade)
        # link_kind = factory.create(:link_kind, :foo)
        # target = supply_entity(link_kind, link[:options])
        # link_kind = supply_entity(link_kind, {name: link[:kind]})
        # Link.build(source: record.central, destination: target.central, link_kind: link_kind)
      end
    end

    def links_factory = @link_factory ||= factory.create(:links)

    def link_kinds = LINK_KINDS

    def links_facade = facade.links

    def link_facades_of_kind(kind)
      message = "#{kind}_links"
      @links_of_kind[kind] ||= links_facade.send(message)
    end
  end
end
