# frozen_string_literal: true

class LintRepositoryJob < ApplicationJob
  queue_as :default

  def perform(check_id)
    check = Repository::Check.find_by(id: check_id)
    return if check.nil?

    repository = check.repository
    check.check!

    begin
      ApplicationContainer[:load_repository].download(repository.id)
      check.result = ApplicationContainer[:linter].check(repository)
      case repository.language
      when 'Ruby'
        check.passed = JSON.parse(check.result)['summary']['offense_count'].zero?
      when 'JavaScript'
        check.passed = JSON.parse(check.result).empty?
      end
      check.finish!
    rescue StandardError
      check.fail!
    end
    ChecksMailer.with(user: repository.user, check: check).linter_results.deliver_now unless check.passed?
  end
end
