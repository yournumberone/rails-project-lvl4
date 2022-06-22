# frozen_string_literal: true

class ApplicationContainer
  extend Dry::Container::Mixin

  if Rails.env.test?
    register :octokit, -> { OctokitClientStub }
    register :load_repository, -> { LoadRepositoryStub }
    register :linter, -> { LinterStub }
  else
    register :octokit, -> { Octokit::Client }
    register :load_repository, -> { LoadRepository }
    register :linter, -> { Linter }
  end
end
