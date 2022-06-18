# frozen_string_literal: true

class AddWebhookStub
  def config
    self
  end

  def hooks(_)
    [self]
  end

  def url
    'https://repository-quality.herokuapp.com'
  end
end
