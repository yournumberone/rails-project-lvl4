# frozen_string_literal: true

class LintRepositoryJob < ApplicationJob
  queue_as :default

  def perform(check_id)
    check = Repository::Check.find_by(id: check_id)
    return if check.nil?

    repository = check.repository
    str = "#{repository.link}.git"
    check.to_checking!

    begin
      `rm -rf "repositories/#{repository.id}"`
      Git.clone(str, "repositories/#{repository.id}")

      case repository.language
      when 'Ruby'
        check.result = `rubocop "repositories/#{repository.id}" --format json`
        check.send_results_email if JSON.parse(check.result)['summary']['offense_count'].positive?
      when 'JavaScript'
        check.result = `npx eslint --no-eslintrc -c .eslintrc.yml -f json "repositories/#{repository.id}"`
      end
      check.check!

    rescue StandardError
      check.fail!
      check.send_results_email
    end
  end
end
