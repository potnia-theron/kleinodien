require "active_support/concern"

module Transitionable
  extend ActiveSupport::Concern

  included do
    before_save :validate_state_change, if: :will_save_change_to_state?
  end

  # def can_change_state_to?(new_state)
  #   allowed_transitions[:new_state]&.include?(new_state.to_sym)
  # end

  # def current_state
  #   state_string_for(state)
  # end

  def state_can_be_changed_to?(new_state)
    new_state_string = state_string_for(new_state)
    allowed_transitions[current_state]&.include?(new_state_string)
  end

  def state_string_for(duck)
    enum_states = self.class.states
    enum_states[duck] ? duck : enum_states.key(duck)
  end

  def validate_state_change
    # new_state = state_string_for(state_change_to_be_saved[1])
    # Rails.logger.info("XXXXXX==== #{state_change_to_be_saved} ... #{current_state} -> #{new_state} >>>>")
    # return if new_state == current_state
    # return if new_state == "failed"

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

  # def state_transiton_valid?
  # def validate_state_change
  #   new_state = state_string_for(state_change_to_be_saved[1])
  #   Rails.logger.info("XXXXXX==== #{state_change_to_be_saved} ... #{current_state} -> #{new_state} >>>>")
  #   return if new_state == current_state
  #   return if new_state == "failed"

  #   raise %(Can't change state from "#{current_state}" to "#{new_state}") unless state_can_be_changed_to? new_state
  # end
end
