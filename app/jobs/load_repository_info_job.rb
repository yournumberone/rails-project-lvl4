# frozen_string_literal: true

class LoadRepositoryInfoJob < ApplicationJob
  include Rails.application.routes.url_helpers
  queue_as :default

  def perform(id)
    repository = Repository.find_by(id: id)
    client = ApplicationContainer[:octokit].new(access_token: repository.user.token)
    repo = client.repo repository.github_id
    repository.update({ name: repo['name'], full_name: repo['full_name'], link: repo['html_url'],
                        language: repo['language'] || repo['parent']['language'] })
    add_webhook(client, repository.github_id)
  end

  private

  def add_webhook(client, repository_id)
    return if client.hooks(repository_id).any? { |hook| hook.config.url.start_with?(ENV.fetch('BASE_URL')) }

    client.create_hook(repository_id, 'web',
                       { url: api_checks_url, content_type: 'json' },
                       { events: %w[push pull_request], active: true })
  end
end
