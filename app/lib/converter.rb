# frozen_string_literal: true

class Converter
  # convert all linters to rubocop style format

  def self.eslint_to_rubocop(result)
    transformed = result.each do |file|
      file['offenses'] = file.delete('messages')
      file['path'] = file.delete('filePath')
      file['offenses'].each do |offense|
        offense['cop_name'] = file.delete('ruleId')
        offense['location'] = { 'start_line' => offense.delete('line'), 'start_column' => offense.delete('column') }
      end
    end
    offense_count = result.reduce(0) { |sum, i| sum + i['errorCount'] + i['warningCount'] }
    { files: transformed, summary: { 'inspected_file_count' => result.size, 'offense_count' => offense_count } }
  end
end
