# frozen_string_literal: true

class Linter
  # convert all linters to rubocop style format

  def self.check(repository)
    case repository.language
    when 'ruby'
      result = `rubocop "tmp/repositories/#{repository.id}" --format json -c .rubocop.yml`
      JSON.parse result
    when 'javascript'
      result = `npx eslint --no-eslintrc -c .eslintrc.yml -f json "tmp/repositories/#{repository.id}" --quiet`
      parsed = JSON.parse result
      Converter.eslint_to_rubocop(parsed)
    end
  end
end
