# frozen_string_literal: true

class Api::ChecksController < Api::ApplicationController
  def create
    repository = Repository.find_by(github_id: params['repository']['id'])
    return if repository.nil?

    check = repository.checks.new
    if check.save
      LintRepositoryJob.perform_later(check.id)
    end
    render json: { '200': 'OK' }, status: :ok
  end
end
