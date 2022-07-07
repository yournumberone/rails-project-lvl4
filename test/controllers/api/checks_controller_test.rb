# frozen_string_literal: true

class Api::ChecksControllerTest < ActionDispatch::IntegrationTest
  test 'create checks on api' do
    repository = repositories(:two)
    assert_difference 'Repository::Check.count' do
      post api_checks_url, params: { 'ref' => 'hook', 'repository' => { 'id' => repository.github_id } }
      assert_response :success
      check = repository.checks.last
      assert { check.aasm_state == 'finished' }
      assert { check.commit == 'https://blabla.test' }
      assert { check.passed == true }
    end
  end
end
