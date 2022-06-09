# frozen_string_literal: true

class RepositoryLoaderJob < ApplicationJob
  queue_as :default

  def perform(object_id)
    object = Repository.find_by(id: object_id)
    return if object.nil?

    str = "#{object.link}.git"
    begin
      Git.clone(str, "repositories/#{object.id}")
    rescue StandardError
      Rails.logger.debug 'oops'
    end
  end
end
