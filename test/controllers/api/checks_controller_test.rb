# frozen_string_literal: true

class Api::ChecksControllerTest < ActionDispatch::IntegrationTest
  test 'create checks on api' do
    assert_difference 'Repository::Check.count' do
      post api_checks_url, params: { 'ref' => 'hook', 'repository' => { 'id' => repositories(:two).github_id } }
      assert_response :success
    end
  end
end
