# frozen_string_literal: true

class Converter
  # convert all linters to eslint style format

  def self.rubocop_to_eslint(result)
    result['files'].map do |file|
      msgs = file['offenses'].map do |o|
        { 'ruleId' => o['cop_name'], 'line' => o['location']['start_line'], 'column' => o['location']['start_column'], 'message' => o['message'] }
      end
      { 'filePath' => file['path'], 'messages' => msgs }
    end
  end
end
