# frozen_string_literal: true

class LoadRepository
  def self.download(id)
    repository = Repository.find_by(id: id)
    `rm -rf "repositories/#{id}"`
    link = "#{repository.link}.git"
    Git.clone(link, "repositories/#{id}")
  end
end