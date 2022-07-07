# frozen_string_literal: true

class Linter
  class << self
    # convert all linters to eslint style format
    def check(repository)
      case repository.language
      when 'ruby'
        result = `rubocop "#{repository_path(repository.id)}" --format json -c .rubocop.yml`
        parsed = JSON.parse result
        Converter.normalize_rubocop(parsed, repository.id)
      when 'javascript'
        result = `npx eslint --no-eslintrc -c .eslintrc.yml -f json "#{repository_path(repository.id)}"`
        parsed = JSON.parse result
        Converter.normalize_eslint(parsed, repository.id)
      end
    end

    def download(id)
      repository = Repository.find_by(id: id)
      `rm -rf "#{repository_path(id)}"`
      begin
        link = "#{repository.link}.git"
        Git.clone(link, repository_path(id))
      rescue StandardError
        Rails.logger.debug { "Repository load failed \n #{'=' * 80}" }
      end
    end

    private

    def repository_path(id)
      "tmp/repositories/#{id}"
    end
  end
end
