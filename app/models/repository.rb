# frozen_string_literal: true

class Repository < ApplicationRecord
  extend Enumerize
  belongs_to :user, class_name: 'User'
  has_many :checks, class_name: 'Repository::Check', dependent: :destroy
  validates :language, presence: true

  enumerize :language, in: %w[JavaScript Ruby]
end
