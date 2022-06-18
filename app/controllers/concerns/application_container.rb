# frozen_string_literal: true

class ApplicationContainer
  extend Dry::Container::Mixin

  if Rails.env.test?
    register :add_webhook, -> { AddWebhookStub }
    register :load_repository, -> { LoadRepositoryStub }
    register :linter, -> { LinterStub }
  else
    register :add_webhook, -> { Octokit::Client }
    register :load_repository, -> { LoadRepository }
    register :linter, -> { Linter }
  end
end
