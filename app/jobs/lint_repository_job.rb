# frozen_string_literal: true

class LintRepositoryJob < ApplicationJob
  queue_as :default

  def perform(check_id)
    check = Repository::Check.find_by(id: check_id)
    return if check.nil?

    @repository = check.repository
    check.check!

    begin
      ApplicationContainer[:load_repository].download(@repository.id)
      check.result = ApplicationContainer[:linter].check(@repository)
      check.passed = (check.result.inject(0) { |sum, i| sum + i['messages'].size }).zero?
      check.commit = last_commit
      check.finish!
    rescue StandardError
      check.fail!
    end
    ChecksMailer.with(user: @repository.user, check: check).linter_results.deliver_now unless check.passed?
  end

  def last_commit
    client = ApplicationContainer[:octokit].new
    resp = client.commits(@repository.github_id, @repository.default_branch)
    resp[0].to_h[:html_url]
  end
end
