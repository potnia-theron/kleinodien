module ImportOrderUri
  module Common
    def code_and_kind = nil

    def import_order_class = ImportOrder

    def code
      code_and_kind&.named_captures&.dig("code")
    end

    def kind
      code_and_kind&.named_captures&.dig("kind")
    end
  end
end
