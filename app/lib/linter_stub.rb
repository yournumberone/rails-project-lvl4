# frozen_string_literal: true

class LinterStub
  def self.check(language, _id)
    File.read(Rails.root.join("test/fixtures/files/#{language || 'JavaScript'}/result.json"))
  end
end
