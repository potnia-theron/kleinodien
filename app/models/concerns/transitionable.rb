require "active_support/concern"

module Transitionable
  extend ActiveSupport::Concern

  included do
    before_save :validate_state_change, if: :will_save_change_to_state?
  end

  def validate_state_change
    old_state, new_state = state_change_to_be_saved

    if old_state == new_state
      Rails.logger.warn("State change to the same state (#{new_state})")
      return
    end

    return if old_state.blank?      # happens when the object is inatantiated
    return if new_state == "failed" # can allways happen
    return if allowed_transitions[old_state]&.include?(new_state)
    raise %(Can't change state from "#{old_state}" to "#{new_state}")
  end
end
