# frozen_string_literal: true

class LintRepositoryJob < ApplicationJob
  queue_as :default

  def perform(check_id)
    check = Repository::Check.find_by(id: check_id)
    return if check.nil?

    repository = check.repository

    check.to_checking!

    begin
      ApplicationContainer[:load_repository].download(repository.id)
      check.result = ApplicationContainer[:linter].check(repository.language, repository.id)
      check.finish!
    rescue StandardError
      check.fail!
    end
    check.send_results_email if check.problems?
  end
end
