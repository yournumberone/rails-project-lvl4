# frozen_string_literal: true

class LinterStub
  def self.check(language, _id)
    case language
    when 'Ruby'
      `rubocop "test/fixtures/files/#{language}" --format json`
    when 'JavaScript'
      `npx eslint --no-eslintrc -c .eslintrc.yml -f json "test/fixtures/files/#{language}"`
    end
  end
end
