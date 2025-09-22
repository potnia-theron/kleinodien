module MusicbrainzFacade
  class Links
    def initialize(factory, options)
      @factory = factory
      @options = options
    end

    # def url_links = links_of_target_type("url").map { factory.create(:link, it) }
    def url_links
      links_of_target_type("url").map { factory.create(:link, it) }
    end

    private

    attr_reader :factory, :options

    def links_of_target_type(target_type)
      options.filter { it[:target_type] == target_type }
    end

    def relations = options[:relations]
  end
end
