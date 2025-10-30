module Ingestor
  class HasManyBuilder
    include Callable

    def initialize(association_name, kits, persister, record)
      @association_name = association_name
      @kits = kits
      @persister = persister
      @record = record
    end

    def call
      kits.each do |assoc_kit|
        assoc_record = RecordBuilder.call(assoc_kit, extra_args: {inverse_name => record}, persister: persister)

        proxy.push(assoc_record)
      end
    end

    private

    attr_reader :association_name, :kits, :persister, :record

    def association = kits.first.association

    def inverse_name = association.inverse_of.name

    def proxy = record.send(association_name)
  end
end
