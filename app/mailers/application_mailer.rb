# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'repository-quality@herokuapp.com'
  layout 'mailer'
end
