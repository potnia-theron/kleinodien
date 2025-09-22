require "active_support/concern"

module BufferableImport
  extend ActiveSupport::Concern

  included do
    enum :state, {open: 0, find_existing: 1, buffering: 2, persisting: 3, done: 4, failed: 5}
  end

  ALLOWED_TRANSITIONS = {
    "open" => ["find_existing"].freeze,
    "find_existing" => ["buffering"],
    "buffering" => ["persisting"].freeze,
    "persisting" => ["done"].freeze,
    "done" => []
  }.freeze

  def allowed_transitions = ALLOWED_TRANSITIONS
end
