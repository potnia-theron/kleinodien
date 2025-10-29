module Ingestion
  class RecordBuilder
    include Callable

    DEFAULT_PERSISTER = NullPersister.new

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
        assoc = Ingestion::RecordBuilder.call(assoc_kit)
        writer = "#{name}="
        record.send(writer, assoc)
      end
    end

    def delegated_type
      delegated_kit = kit.delegated_type_kit
      return unless delegated_kit

      name = reflections.record_class.reflect_on_all_associations(:belongs_to).filter(&:foreign_type).first.name
      habs_schon = record.send name
      return if habs_schon

      my_delegated_type = RecordBuilder.call(delegated_kit)
      writer = "#{name}="
      record.send(writer, my_delegated_type)

      my_delegated_type
    end

    def has_many
      has_many_kits.each do |association_name, kits|
        next if kits.none?
        proxy = record.send association_name

        my_assoc = kits.first.association
        inverse_name = my_assoc.inverse_of.name

        kits.each do |assoc_kit|
          assoc_record = RecordBuilder.call(assoc_kit, extra_args: {inverse_name => record}, persister: persister)
          proxy.push(assoc_record)
        end
      end
    end

    def record = @record ||= reflections.record_class.new(record_attributes)

    def record_attributes = inherent_attributes.merge(extra_args)
  end
end
