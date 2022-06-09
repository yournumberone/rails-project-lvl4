# frozen_string_literal: true

class RepositoryLoaderJob < ApplicationJob
  queue_as :default

  def perform(object_id)
    object = Repository.find_by(id: object_id)
    puts '1*' * 80
    return if object.nil?
    puts '2*' * 80
    str = "#{object.link}.git"
    puts '3*' * 80
    begin
      Git.clone(str, "repositories/#{object.id}")
      puts '4*' * 80
    rescue StandardError
      puts '4.2*' * 80
      Rails.logger.debug 'oops'
    end
  end
end
