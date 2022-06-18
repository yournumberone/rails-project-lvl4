# frozen_string_literal: true

class Linter
  def self.check(language, id)
    case language
    when 'Ruby'
      `rubocop "repositories/#{id}" --format json`
    when 'JavaScript'
      `npx eslint --no-eslintrc -c .eslintrc.yml -f json "repositories/#{id}"`
    end
  end
end
