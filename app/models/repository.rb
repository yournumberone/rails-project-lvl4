# frozen_string_literal: true

class Repository < ApplicationRecord
  extend Enumerize
  belongs_to :user, class_name: 'User'
  has_many :checks, class_name: 'Repository::Check', dependent: :destroy
  validates :github_id, presence: true

  enumerize :language, in: %w[javascript ruby]
end
