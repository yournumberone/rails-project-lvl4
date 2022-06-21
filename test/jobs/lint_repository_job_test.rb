# frozen_string_literal: true

require 'test_helper'

class LintRepositoryJobTest < ActiveJob::TestCase
  setup do
    @ruby_check = repository_checks(:ruby)
    @js_check = repository_checks(:js)
  end

  test 'check ruby' do
    LintRepositoryJob.perform_now(@ruby_check.id)
    @ruby_check.reload
    assert { @ruby_check.aasm_state == 'finished' }
  end

  test 'check js' do
    LintRepositoryJob.perform_now(@js_check.id)
    @js_check.reload
    assert { @js_check.aasm_state == 'finished' }
  end
end
