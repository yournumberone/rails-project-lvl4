# frozen_string_literal: true

class Linter
  # convert all linters to eslint style format

  def self.check(repository)
    case repository.language
    when 'ruby'
      result = `rubocop "tmp/repositories/#{repository.id}" --format json -c .rubocop.yml`
      parsed = JSON.parse result
      Converter.rubocop_to_eslint(parsed)
    when 'javascript'
      result = `npx eslint --no-eslintrc -c .eslintrc.yml -f json "tmp/repositories/#{repository.id}"`
      JSON.parse result
    end
  end
end
