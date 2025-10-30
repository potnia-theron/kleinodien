module Ingestor
  class RecordBuilder
    include Callable

    DEFAULT_PERSISTER = Ingestion::NullPersister.new

    def initialize(kit, persister: DEFAULT_PERSISTER, extra_args: {})
      @kit = kit
      @persister = persister
      @extra_args = extra_args
    end

    def call
      find || build
    end

    private

    def find
      finder = kit.reflections.create_finder
      finder.call(kit.facade)
    end

    def build
      delegated_type
      belongs_to
      persister.call(record)
      has_many

      RecordEnhancer.call(kit, persister, record)

      record
    end

    attr_reader :extra_args, :kit, :persister

    delegate_missing_to :kit

    def belongs_to
      return unless belongs_to_associations.any?

      belongs_to_kits.each do |name, assoc_kit|
        assoc = Ingestor::RecordBuilder.call(assoc_kit)
        writer = "#{name}="
        record.send(writer, assoc)
      end
    end

    def delegated_type
      delegated_kit = kit.delegated_type_kit
      return unless delegated_kit

      type_name = delegated_type_association.name
      return if record.send type_name

      writer = "#{type_name}="
      delegated_record = RecordBuilder.call(delegated_kit)
      record.send(writer, delegated_record)
    end

    def has_many
      has_many_kits.each do |association_name, kits|
        next if kits.none?

        HasManyBuilder.call(association_name, kits, persister, record)
      end
    end

    def record = @record ||= reflections.record_class.new(record_attributes)

    def record_attributes = inherent_attributes.merge(extra_args)
  end
end
