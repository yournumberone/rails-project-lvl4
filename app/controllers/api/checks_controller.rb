# frozen_string_literal: true

class Api::ChecksController < Api::ApplicationController
  def create
    return unless params.key?('ref')

    repository = Repository.find_by(github_id: params['repository']['id'])
    return if repository.nil?

    check = repository.checks.new
    LintRepositoryJob.perform_later(check.id) if check.save
    render json: { '200': 'I don\'t wanna flirt with you, but I really wanna see a green pipeline' }, status: :ok
  end
end
