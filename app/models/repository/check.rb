# frozen_string_literal: true

class Repository::Check < ApplicationRecord
  include AASM
  belongs_to :repository, class_name: 'Repository'

  aasm column: :status, whiny_transitions: false do
    state :created, initial: true
    state :checking
    state :checked
    state :failed

    event :to_checking do
      transitions from: %i[created], to: :checking
    end

    event :check do
      transitions from: %i[checking], to: :checked
    end

    event :fail do
      transitions from: :checking, to: :failed
    end
  end

  def send_results_email
    ChecksMailer.with(user: repository.user, check: self).linter_results.deliver_now
  end

  def problems?
    JSON.parse(result).size.positive? || failed?
  end
end
