# frozen_string_literal: true

class LoadRepository
  def self.download(link, id)
    `rm -rf "repositories/#{id}"`
    Git.clone(link, "repositories/#{id}")
  end
end
