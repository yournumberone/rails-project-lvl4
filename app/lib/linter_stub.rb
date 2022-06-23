# frozen_string_literal: true

class LinterStub
  def self.check(repository)
    repository.language ||= 'Ruby'
    repository.save
    File.read(Rails.root.join("test/fixtures/files/#{repository.language}/result.json"))
  end
end
