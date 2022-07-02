# frozen_string_literal: true

class OctokitClientStub
  def initialize(*options); end

  def config
    self
  end

  def hooks(_)
    [self]
  end

  def url
    ''
  end

  def repo(_id)
    JSON.parse File.read(Rails.root.join('test/fixtures/files/response.json'))
  end

  def repos
    JSON.parse File.read(Rails.root.join('test/fixtures/files/response.json'))
  end

  def create_hook(*_args)
    'Hook was created.'
  end
end
