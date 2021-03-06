# frozen_string_literal: true

class Web::Repositories::ChecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:two)
    sign_in @user
    @repository = repositories(:two)
    @check = repository_checks(:js)
  end

  test 'get show' do
    get repository_check_url(@repository.id, @check.id)
    assert_response :success
  end

  test 'create check' do
    assert_difference 'Repository::Check.count' do
      post repository_checks_url(@repository)
    end
    check = @repository.checks.last
    assert { check.finished? }
    assert { check.commit == 'https://blabla.test' }
    assert { check.passed == true }
  end
end
