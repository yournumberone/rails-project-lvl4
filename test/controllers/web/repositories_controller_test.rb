# frozen_string_literal: true

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
    @response = file_fixture('response.json').read
    @headers = {
      'Authorization' => '*',
      'Content-Type' => 'application/json'
    }
  end

  test 'get index' do
    repositories = @user.repositories
    get repositories_url

    assert_response :success
    assert { repositories.size == 1 }
  end

  test 'get new' do
    stub_request(:get, /api.github.com/)
      .to_return(status: 200, body: @response, headers: @headers)
    get new_repository_url
    assert_response :success
  end

  test 'create repository' do
    stub_request(:get, /api.github.com/)
      .to_return(status: 200, body: @response, headers: @headers)
    post repositories_url, params: { repository: { github_id: 479_483_417 } }
    repository = Repository.find_by(link: 'https://github.com/yournumberone/rails-project-lvl2')

    assert_redirected_to repository_url(repository)
  end

  test 'destroy repository' do
    repository = repositories(:one)
    delete repository_url(repository)
    assert_not(Repository.exists?(repository.id))

    assert_redirected_to repositories_url
  end
end
