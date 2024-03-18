module Import
  class FacadeList
    include Enumerable

    # def initialize(session, data:, model:)
    def initialize(session, model:, **options)
      @session = session
      # @data = data
      @options = options
      @model = model
    end

    # attr_reader :data, :model, :session
    attr_reader :model, :options, :session

    delegate :each, to: :facades

    def data
      @options[:data]
    end

    def facades
      data.map.with_index(1) do |data, index|
        # options = {
        #   consecutive_number: index,
        #   data: data
        # }
        # options[:consecutive_number] = index
        x = options.merge(
          {
            consecutive_number: index,
            data: data

          }
        )
        session.build_facade(model, **x)
      end
    end
    # def facades
    #   data.map.with_index(1) do |item, index|
    #     session.build_facade(model, item, consecutive_number: index)
    #   end
    # end
  end
end
