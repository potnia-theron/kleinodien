module Import
  class MusicbrainzLinkFacade
    def initialize(relations)
      @relations = relations
    end

    def url_links = links_of_target_type("url").map { {kind: it[:type], options: it[:url]} }

    private

    attr_reader :relations

    def links_of_target_type(target_type)
      relations.filter { it[:target_type] == target_type }
    end
  end
end
