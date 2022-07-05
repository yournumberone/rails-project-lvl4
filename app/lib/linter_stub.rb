# frozen_string_literal: true

class LinterStub
  def self.check(repository)
    JSON.parse File.read(Rails.root.join("test/fixtures/files/#{repository.language}/result.json"))
  end
end
