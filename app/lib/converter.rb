# frozen_string_literal: true

class Converter
  # convert all linters to eslint style format

  def self.normalize_rubocop(result, id)
    files = result['files'].map do |file|
      msgs = file['offenses'].map do |o|
        { 'rule' => o['cop_name'], 'line_column' => "#{o['location']['start_line']}:#{o['location']['start_column']}", 'message' => o['message'] }
      end
      { 'path' => file['path'].sub(%r{.*/#{id}}, ''), 'messages' => msgs } if msgs.present?
    end
    files.compact!(&:nil?)
    { files: files, problems_file_count: files.size, offense_count: result['summary']['offense_count'] }
  end

  def self.normalize_eslint(result, id)
    files = result.map do |file|
      msgs = file['messages'].map do |o|
        { 'rule' => o['ruleId'], 'line_column' => "#{o['line']}:#{o['column']}", 'message' => o['message'] }
      end
      { 'path' => file['filePath'].sub(%r{.*/#{id}}, ''), 'messages' => msgs } if msgs.present?
    end
    files.compact! { |f| f['messages'].nil? }
    { files: files, problems_file_count: files.size, offense_count: files.inject(0) { |sum, i| sum + i['messages'].size } }
  end
end
