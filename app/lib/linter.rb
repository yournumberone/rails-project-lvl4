# frozen_string_literal: true

class Linter
  def self.check(repository)
    case repository.language
    when 'Ruby'
      `rubocop "repositories/#{repository.id}" --format json`
    when 'JavaScript'
      `npx eslint --no-eslintrc -c .eslintrc.yml -f json "repositories/#{repository.id}" --quiet`
    end
  end
end
