# frozen_string_literal: true

class Repository::Check < ApplicationRecord
  include AASM
  belongs_to :repository, class_name: 'Repository'

  aasm column: :aasm_state, whiny_transitions: false do
    state :created, initial: true
    state :checking
    state :finished
    state :failed

    event :check do
      transitions from: %i[created], to: :checking
    end

    event :finish do
      transitions from: %i[checking], to: :finished
    end

    event :fail do
      transitions from: :checking, to: :failed
    end
  end
end
