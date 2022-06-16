# frozen_string_literal: true

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
    @response = file_fixture('response.json').read
    @headers = {
      'Accept' => '*/*',
      'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Authorization' => '*',
      'Content-Type' => 'application/json',
      'User-Agent' => 'Octokit Ruby Gem 4.23.0'
    }
  end

  test 'should get index' do
    repositories = @user.repositories
    get repositories_url

    assert_response :success
    assert { repositories.size == 1 }
  end

  test 'should get new' do
    # @uri_template = Addressable::Template.new 'https://api.github.com/user/repos?per_page=100'
    # @headers.merge({ 'Authorization' => 'token ghu_lTOxGwZuOdwIYalfTWaIZgDKVyaTJW2hqWYW' })
    stub_request(:get, /api.github.com/)
      .to_return(status: 200, body: @response, headers: @headers)
    get new_repository_url
    assert_response :success
  end

  test 'should create repository' do
    stub_request(:get, /api.github.com/)
      .to_return(status: 200, body: @response, headers: @headers)
    post repositories_url, params: { repository: { github_id: 1296269 } }
    repository = Repository.find_by(link: 'https://github.com/octocat/Hello-World')
    puts repository.inspect
    assert_redirected_to repository_url(repository)
  end
end
