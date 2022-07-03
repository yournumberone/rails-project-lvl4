# frozen_string_literal: true

class Linter
  def self.check(repository)
    case repository.language
    when 'Ruby'
      `rubocop "tmp/repositories/#{repository.id}" --format json -c .rubocop.yml`
    when 'JavaScript'
      `npx eslint --no-eslintrc -c .eslintrc.yml -f json "tmp/repositories/#{repository.id}" --quiet`
    end
  end
end
