# frozen_string_literal: true

class ApplicationContainer
  extend Dry::Container::Mixin

  if Rails.env.test?
    register :octokit, -> { OctokitClientStub }
    register :linter, -> { LinterStub }
  else
    register :octokit, -> { Octokit::Client }
    register :linter, -> { Linter }
  end
end
