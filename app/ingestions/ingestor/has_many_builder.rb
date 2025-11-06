module Ingestor
  class HasManyBuilder
    include Callable

    def initialize(kit, persister, record)
      @kit = kit
      @persister = persister
      @record = record
    end

    def call
      kit.kits.each do |assoc_kit|
        assoc_record = RecordBuilder.call(assoc_kit, extra_args: {inverse_name => record}, persister: persister)
        proxy.push(assoc_record)
      end
    end

    private

    attr_reader :association_name, :kit, :persister, :record

    def association = kit.association

    def inverse_name = association.inverse_of.name

    def proxy = record.send(association.name)
  end
end
