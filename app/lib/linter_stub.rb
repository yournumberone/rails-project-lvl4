# frozen_string_literal: true

# not intended for Github Actions
class LinterStub
  def self.check(language, _id)
    File.read(Rails.root.join("test/fixtures/files/#{language}/result.json"))
  end
end
