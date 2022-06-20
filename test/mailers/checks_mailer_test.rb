# frozen_string_literal: true

require 'test_helper'

class ChecksMailerTest < ActionMailer::TestCase
  test 'send email' do
    assert_emails 1 do
      check = repository_checks(:ruby)
      check.fail!
      check.reload
      check.send_results_email
    end
  end
end
