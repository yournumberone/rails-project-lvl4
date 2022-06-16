# frozen_string_literal: true

class Api::ChecksController < Api::ApplicationController
  def create
    return unless params.key?('ref')

    repository = Repository.find_by(github_id: params['repository']['id'])
    return if repository.nil?

    check = repository.checks.new
    LintRepositoryJob.perform_later(check.id) if check.save
  end
end
