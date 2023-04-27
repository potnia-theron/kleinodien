module ImportOrderUri
  KindAndCode = Data.define(:kind, :code)

  module Common
    def kind_and_code = nil

    def import_order_class = ImportOrder

    def import_order_type = "ImportOrder"

    def code
      # kind_and_code&.named_captures&.dig("code")
      kind_and_code&.code
    end

    def kind
      # kind_and_code&.named_captures&.dig("kind")
      kind_and_code&.kind
    end
  end
end
