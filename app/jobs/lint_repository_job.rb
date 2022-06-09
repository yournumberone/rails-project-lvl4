# frozen_string_literal: true

class LintRepositoryJob < ApplicationJob
  queue_as :default

  def perform(check_id)
    check = Repository::Check.find_by(id: check_id)
    return if check.nil?

    repository = check.repository
    RepositoryLoaderJob.perform_now(repository.id)
    check.to_checking!
    begin
      case repository.language
      when 'Ruby'
        check.result = `rubocop "#{Rails.root.join('repositories', repository.id.to_s)}" --format json`
      when 'JavaScript'
        check.result = `npx eslint -c .eslintrc.yml --no-eslintrc -f json "#{Rails.root.join('repositories', repository.id.to_s)}"`
      end
      check.check!
    rescue TypeError
      check.fail!
    end
  end
end
