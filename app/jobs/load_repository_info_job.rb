# frozen_string_literal: true

class LoadRepositoryInfoJob < ApplicationJob
  queue_as :default

  def perform(id)
    repository = Repository.find_by(id: id)
    client = ApplicationContainer[:octokit].new
    repo = client.repo repository.github_id
    repository.update({ name: repo['name'], full_name: repo['full_name'], link: repo['html_url'],
                        language: repo['language'] || repo['parent']['language'] })
  end
end
