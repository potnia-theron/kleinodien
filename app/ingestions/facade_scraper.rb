module FacadeScraper
  def self.build(&block) = Builder.call(&block)
end
