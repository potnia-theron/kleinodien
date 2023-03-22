require "active_support/concern"

module Transitionable
  extend ActiveSupport::Concern

  def can_change_state_to?(new_state)
    allowed_transitions[:new_state]&.include?(new_state.to_sym)
  end

  def state=(new_state)
    return if new_state.to_sym == state.to_sym
    raise ArgumentError, %(Can't change state from "#{state}" to "#{new_state}") unless can_change_state_to?(new_state)

    self[:state] = new_state
  end
end
